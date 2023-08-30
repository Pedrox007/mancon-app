import 'package:flutter/material.dart';
import 'package:mancon_app/pages/home_page.dart';
import 'package:mancon_app/pages/splash_screen_page.dart';
import 'package:mancon_app/themes/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: UiConfig.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreenPage(),
        '/home': (context) => const HomePage(title: "Page"),
      },
    );
  }
}
