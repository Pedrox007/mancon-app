import 'package:flutter/material.dart';

class UiConfig {
  UiConfig._();

  static String get title => 'Mancon';

  static ThemeData get theme => ThemeData(
        colorScheme: const ColorScheme(
          primary: Color.fromRGBO(255, 145, 77, 1),
          primaryContainer: Color.fromRGBO(255, 145, 77, 0.5),
          secondary: Colors.white,
          surface: Color.fromRGBO(66, 67, 71, 0.5),
          background: Color.fromRGBO(66, 67, 71, 1),
          error: Color.fromARGB(255, 255, 75, 75),
          onPrimary: Color.fromARGB(255, 0, 70, 67),
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onError: Colors.white,
          brightness: Brightness.dark,
        ),
      );
}
