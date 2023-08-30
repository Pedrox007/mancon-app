import 'package:flutter/material.dart';

class UiConfig {
  UiConfig._();

  static String get title => 'Mancon';

  static ThemeData get theme => ThemeData(
        colorScheme: const ColorScheme(
          primary: Color.fromARGB(255, 250, 244, 211),
          secondary: Color.fromARGB(255, 0, 70, 67),
          surface: Color(0xFF0C1618),
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
