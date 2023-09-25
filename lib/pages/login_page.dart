import 'package:flutter/material.dart';
import 'package:mancon_app/state/logged_user.dart';
import 'package:mancon_app/widgets/button_icon.dart';
import 'package:mancon_app/widgets/input.dart';
import 'package:mancon_app/widgets/logo.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameEC = TextEditingController();
  final passwordEC = TextEditingController();

  void _confirmLogin(BuildContext context) {
    Provider.of<LoggedUser>(context, listen: false)
        .setMockedUser(username: usernameEC.text);

    Navigator.of(context).pushNamedAndRemoveUntil("/home", (_) => false);
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
                onPressed: () {
                  _confirmLogin(context);
                },
                icon: Icons.login,
              )
            ],
          ),
        ),
      ),
    );
  }
}
