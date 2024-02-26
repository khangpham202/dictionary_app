import 'package:flutter/material.dart';

enum AppLocales {
  en(Locale('en', 'US')),
  vi(Locale('vi', 'VN'));

  const AppLocales(
    this.locale,
  );
  final Locale locale;
  static String get path => 'assets/locales';
  static AppLocales get defaultValue => en;
}
