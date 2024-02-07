import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'language_event.dart';
part 'language_state.dart';

class CountryBloc extends Bloc<LanguageEvent, LanguageState> {
  CountryBloc() : super(LanguageInitial()) {
    on<LanguageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
