import 'package:flutter/material.dart';
import 'package:mancon_app/pages/expense_add_page.dart';
import 'package:mancon_app/pages/expenses_page.dart';
import 'package:mancon_app/pages/home_page.dart';
import 'package:mancon_app/pages/login_page.dart';
import 'package:mancon_app/pages/splash_screen_page.dart';
import 'package:mancon_app/pages/user_details_page.dart';
import 'package:mancon_app/state/expense_list.dart';
import 'package:mancon_app/state/expense_type_list.dart';
import 'package:mancon_app/state/logged_user.dart';
import 'package:mancon_app/themes/styles.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoggedUser()),
        ChangeNotifierProvider(create: (context) => ExpenseList()),
        ChangeNotifierProvider(create: (context) => ExpenseTypeList()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: UiConfig.theme,
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          "/": (context) => const SplashScreenPage(),
          "/home": (context) => const HomePage(),
          "/login": (context) => const LoginPage(),
          "/expenses": (context) => const ExpensesPage(),
          "/user-details": (context) => const UserDetailsPage(),
          "/expense-add": (context) => const ExpenseAddPage()
        },
      ),
    );
  }
}
