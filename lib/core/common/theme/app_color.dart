import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  //light Theme
  static const kPrimaryLight = Color(0xff121F3E);
  static const kSecondaryLight = Color(0xff003074);

//Dark Theme
  static const kPrimaryDark = Color(0xff356AD1);
  static const kDarkBlack = Color(0xff1A1F2E);

//Comon theme
  static const kYellow = Color(0xffFBBC05);
  static const kRed = Color(0xffFD2A2A);
  static const kGreen = Color(0xff00BF71);
  static const kWhite = Colors.white;
  static const kLightBlue = Color(0xffECF3FA);
  static const kBorderColor = Color(0xffC3C4C5);
  static Color get pageBackground => kWhite;

  static const MaterialColor kprimary =
      MaterialColor(kPrimaryValue, <int, Color>{
    50: Color(0xFFEBEEFA),
    100: Color(0xFFDEE6F8),
    200: Color(0xFFC9D7F3),
    300: Color(0xFFA4BCEA),
    400: Color(0xFF7A9DE1),
    500: Color(kPrimaryValue),
    600: Color(0xFF356AD1),
    700: Color(0xFF2C5EBF),
    800: Color(0xFF003F99),
    900: Color(0xFF003074),
  });

  static const MaterialColor kprimaryAccent =
      MaterialColor(_kprimaryAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_kprimaryAccentValue),
    400: Color(0xFF9DB5FF),
    700: Color(0xFF84A2FF),
  });
  static const int _kprimaryAccentValue = 0xFFD0DCFF;

  static const MaterialColor kGreyscale =
      MaterialColor(kGreyPrimaryValue, <int, Color>{
    50: Color(0xFFF0F5F9),
    100: Color(0xFFF3F7F9),
    200: Color(0xFFE8EAEE),
    300: Color(0xFFD0D5DC),
    400: Color(0xFFB6BEC9),
    500: Color(kGreyPrimaryValue),
    600: Color(0xFF697896),
    700: Color(0xFF121F3E),
    800: Color(0xFF21273B),
    900: Color(0xFF191D2B),
  });

  static const MaterialColor kgreyAccent =
      MaterialColor(kGreyAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(kGreyAccentValue),
    400: Color(0xFF9EBBFF),
    700: Color(0xFF85A9FF),
  });
  static const int kGreyAccentValue = 0xFFD1DFFF;
  static const int kGreyPrimaryValue = 0xFF96A0B5;
  static const int kPrimaryValue = 0xFF5984D9;
}
