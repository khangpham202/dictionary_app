part of 'language_bloc.dart';

abstract class LanguageEvent {}

class ChangeSourceLanguageEvent extends LanguageEvent {
  final Language selectedLanguage;

  ChangeSourceLanguageEvent(this.selectedLanguage);
  List<Object> get props => [selectedLanguage];
}

class ChangeTargetLanguageEvent extends LanguageEvent {
  final Language selectedLanguage;

  ChangeTargetLanguageEvent(this.selectedLanguage);
  List<Object> get props => [selectedLanguage];
}
