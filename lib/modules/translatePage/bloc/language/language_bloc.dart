import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training/core/enum/country.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageSelected(Country.United_Kingdom)) {
    on<ChangeSourceLanguageEvent>((event, emit) {
      emit(LanguageSelected(event.selectedCountry));
    });
    on<ChangeTargetLanguageEvent>((event, emit) {
      emit(LanguageSelected(event.selectedCountry));
    });
  }
}
