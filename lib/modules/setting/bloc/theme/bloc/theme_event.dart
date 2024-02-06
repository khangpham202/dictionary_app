part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

final class DarkTheme extends ThemeEvent {}

final class LightTheme extends ThemeEvent {}
