part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {
  final ThemeData themeData;

  const ThemeState(this.themeData);

  List<Object> get props => [themeData];
}

final class ThemeMode extends ThemeState {
  const ThemeMode(ThemeData themeData) : super(themeData);
}
