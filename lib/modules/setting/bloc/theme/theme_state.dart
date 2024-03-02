part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

class ThemeInitial extends ThemeState {
  const ThemeInitial(ThemeMode themeMode) : super(themeMode);
}
