import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:training/util/theme_helper.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial(ThemeData.light())) {
    // on<ThemeEvent>((event, emit) {});

    //when app is started
    on<InitialThemeSetEvent>((event, emit) async {
      final bool hasDarkTheme = await isDark();
      if (hasDarkTheme) {
        emit(ThemeState(ThemeData.dark()));
      } else {
        emit(ThemeState(ThemeData.light()));
      }
    });

    //while switch is clicked
    on<ThemeSwitchEvent>((event, emit) {
      final isDark = state.themeData == ThemeData.dark();
      emit(isDark
          ? ThemeState(ThemeData.light())
          : ThemeState(ThemeData.dark()));
      setTheme(isDark);
    });
  }
}
