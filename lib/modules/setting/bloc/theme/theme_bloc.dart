import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:training/util/shared_preferences_helper.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeInitial(ThemeMode.light)) {
    //when app is started
    on<InitialThemeSetEvent>((event, emit) async {
      final bool hasDarkTheme = await isDark();
      if (hasDarkTheme) {
        emit(const ThemeState(ThemeMode.dark));
      } else {
        emit(const ThemeState(ThemeMode.light));
      }
    });

    //while switch is clicked
    on<ThemeSwitchEvent>((event, emit) {
      final isDark = state.themeMode == ThemeMode.dark;
      emit(isDark
          ? const ThemeState(ThemeMode.light)
          : const ThemeState(ThemeMode.dark));
      setTheme(isDark);
    });
  }
}
