// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mancon_app/models/user.dart';
import 'package:mancon_app/services/user_service.dart';
import 'package:mancon_app/state/logged_user.dart';
import 'package:mancon_app/widgets/splash_screen_widget.dart';
import 'package:provider/provider.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  double imageSize = 150;
  double textOpacity = 0;
  bool loading = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        imageSize += 30;
      });

      await Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          textOpacity = 1;
        });
      });

      Future.delayed(const Duration(seconds: 3), () async {
        setState(() {
          loading = true;
        });

        UserService service = UserService();

        bool success = await service.renewToken();

        if (success) {
          http.Response response = await service.getUser();
          if (response.statusCode == 200) {
            var json = jsonDecode(response.body);
            User loggedUser = User.fromMap(json);
            Provider.of<LoggedUser>(context, listen: false).setUser(loggedUser);
            Navigator.pushNamedAndRemoveUntil(
                context, "/home", (route) => false);
          }
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, "/login", (route) => false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SplashScreenWidget(
        imageSize: imageSize,
        textOpacity: textOpacity,
        loading: loading,
      ),
    );
  }
}
