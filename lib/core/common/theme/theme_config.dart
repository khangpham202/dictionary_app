import 'package:flutter/material.dart';

class ThemeDataStyle {
  static const lightColorScheme = ColorScheme.light(
    primary: Color.fromRGBO(18, 55, 149, 0.914),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Colors.grey,
    onSecondary: Color.fromARGB(255, 13, 12, 12),
    primaryContainer: Color(0xFFFFD8E6),
    onPrimaryContainer: Color.fromARGB(255, 241, 237, 237),
  );
  static const darkColorScheme = ColorScheme.dark(
    primary: Color.fromRGBO(17, 29, 60, 0.914),
    onPrimary: Color.fromARGB(255, 61, 59, 59),
    secondary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF792952),
    onPrimaryContainer: Color.fromARGB(255, 201, 197, 197),
  );
}
