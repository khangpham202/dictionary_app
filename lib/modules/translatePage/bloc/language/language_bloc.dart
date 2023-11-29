import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    on<LanguageEvent>((event, emit) {
      if (event is ChangeLanguageEvent) {
        emit(LanguageInitial(
          sourceLanguage: event.sourceLanguage,
          targetLanguage: event.targetLanguage,
        ));
      }
    });
  }
}
