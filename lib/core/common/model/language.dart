import 'dart:ui';

enum Language {
  english(
    Locale('en', 'US'),
    'English',
  ),
  greek(
    Locale('vi', 'VN'),
    'Vietnamese',
  );

  const Language(
    this.value,
    this.text,
  );

  final Locale value;
  final String text;
}
