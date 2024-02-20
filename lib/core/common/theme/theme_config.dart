import 'package:flutter/material.dart';

class ThemeDataStyle {
  static const lightColorScheme = ColorScheme.light(
    primary: Color.fromRGBO(18, 55, 149, 0.914),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFFD8E6),
    onPrimaryContainer: Color(0xFF3D0024),
    secondary: Color(0xFF735761),
  );
  static const darkColorScheme = ColorScheme.dark(
    primary: Color.fromRGBO(17, 29, 60, 0.914),
    onPrimary: Color(0xFF5C113B),
    primaryContainer: Color(0xFF792952),
    onPrimaryContainer: Color(0xFFFFD8E6),
    secondary: Color(0xFFE1BDCA),
    onSecondary: Color(0xFF412A33),
  );
}
