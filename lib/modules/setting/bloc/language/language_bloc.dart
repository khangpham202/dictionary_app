import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/model/language.dart';

part 'language_event.dart';
part 'language_state.dart';

class CountryLanguageBloc
    extends Bloc<CountryLanguageEvent, CountryLanguageState> {
  CountryLanguageBloc() : super(const CountryLanguageState()) {
    on<CountryLanguageEvent>((event, emit) {
      on<ChangeLanguage>(
          (ChangeLanguage event, Emitter<CountryLanguageState> emit) {
        emit(state.copyWith(selectedLanguage: event.selectedLanguage));
      });
    });
  }
}
