import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training/core/enum/country.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<LanguageEvent, LanguageState> {
  CountryBloc() : super(const LanguageSelected(Country.United_Kingdom)) {
    on<ChangeSourceLanguageEvent>((event, emit) {
      emit(LanguageSelected(event.selectedCountry));
    });
    on<ChangeTargetLanguageEvent>((event, emit) {
      emit(LanguageSelected(event.selectedCountry));
    });
  }
}
