part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  final ThemeData themeData;

  const ThemeState(this.themeData);

  @override
  List<Object> get props => [];
}

final class ThemeMode extends ThemeState {
  const ThemeMode(ThemeData themeData) : super(themeData);
}
