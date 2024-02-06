import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';


class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeMode(ThemeData.light())) {
    on<DarkTheme>((event, emit) {
      emit(ThemeMode(ThemeData.dark()));
    });
    on<LightTheme>((event, emit) {
      emit(ThemeMode(ThemeData.light()));
    });
  }
}
