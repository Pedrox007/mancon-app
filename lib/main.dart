import 'package:flutter/material.dart';
import 'package:mancon_app/pages/home_page.dart';
import 'package:mancon_app/pages/login_page.dart';
import 'package:mancon_app/pages/splash_screen_page.dart';
import 'package:mancon_app/state/expense_list.dart';
import 'package:mancon_app/state/logged_user.dart';
import 'package:mancon_app/themes/styles.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoggedUser()),
        ChangeNotifierProvider(create: (context) => ExpenseList())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: UiConfig.theme,
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          "/": (context) => const SplashScreenPage(),
          "/home": (context) => const HomePage(title: "Page"),
          "/login": (context) => const LoginPage(),
        },
      ),
    );
  }
}
