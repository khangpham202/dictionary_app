part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

final class DarkTheme extends ThemeEvent {}

final class LightTheme extends ThemeEvent {}
