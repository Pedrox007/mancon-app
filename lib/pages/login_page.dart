// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:mancon_app/models/user.dart';
import 'package:mancon_app/services/user_service.dart';
import 'package:mancon_app/state/logged_user.dart';
import 'package:mancon_app/utils/secure_storage.dart';
import 'package:mancon_app/widgets/button_icon.dart';
import 'package:mancon_app/widgets/input.dart';
import 'package:mancon_app/widgets/logo.dart';
import 'package:mancon_app/utils/notification_message.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameEC = TextEditingController();
  final passwordEC = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();

    _getUsername();
    _checkPassword();
  }

  void _getUsername() async {
    SecureStorage storage = SecureStorage();

    String username = await storage.readSecureData("username");

    if (username != "") {
      usernameEC.text = username;
    }
  }

  void _checkPassword() async {
    SecureStorage storage = SecureStorage();
    LocalAuthentication localAuthentication = LocalAuthentication();

    String password = await storage.readSecureData("password");

    if (password != "") {
      bool isBiometricAvailable = await localAuthentication.canCheckBiometrics;
      bool isDeviceSupported = await localAuthentication.isDeviceSupported();

      if (isBiometricAvailable && isDeviceSupported) {
        bool isAuthenticated = await localAuthentication.authenticate(
          localizedReason: "Autenticação utilizando biometria",
        );

        if (isAuthenticated) {
          passwordEC.text = password;

          _confirmLogin();
        }
      }
    }
  }

  void _confirmLogin() async {
    setState(() {
      loading = true;
    });

    UserService service = UserService();
    SecureStorage storage = SecureStorage();
    http.Response responseToken =
        await service.getToken(usernameEC.text, passwordEC.text);

    if (responseToken.statusCode == 200) {
      var body = jsonDecode(responseToken.body);
      storage.writeSecureData("access_token", body["access"]);
      storage.writeSecureData("refresh_token", body["refresh"]);
      service.updateAuthorization(await storage.readSecureData("access_token"));

      http.Response responseUser = await service.getUser();
      if (responseUser.statusCode == 200) {
        var json = jsonDecode(responseUser.body);
        User loggedUser = User.fromMap(json);
        storage.writeSecureData("username", loggedUser.username);
        storage.writeSecureData("password", passwordEC.text);
        Provider.of<LoggedUser>(context, listen: false).setUser(loggedUser);
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
      } else {
        NotificationMessage().showNotification(
          message:
              "Erro! Não foi possível capturar dados do usuário. Tente novamente.",
          context: context,
          error: true,
        );
        passwordEC.clear();
      }
    } else {
      NotificationMessage().showNotification(
        message: "Erro! Usuário ou senha estão incorretos. Tente novamente.",
        context: context,
        error: true,
      );
      passwordEC.clear();
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Logo(size: 50),
              const SizedBox(height: 40),
              Input(
                label: "Nome de usuário",
                preffixIcon: const Icon(Icons.person),
                type: TextInputType.text,
                controller: usernameEC,
              ),
              const SizedBox(height: 20),
              Input(
                label: "Senha",
                preffixIcon: const Icon(Icons.lock),
                type: TextInputType.text,
                obscureText: true,
                controller: passwordEC,
              ),
              const SizedBox(height: 40),
              ButtonIcon(
                label: "Entrar",
                loading: loading,
                onPressed: _confirmLogin,
                icon: Icons.login,
              )
            ],
          ),
        ),
      ),
    );
  }
}
