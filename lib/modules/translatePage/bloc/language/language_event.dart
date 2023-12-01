part of 'language_bloc.dart';

abstract class LanguageEvent {}

class ChangeSourceLanguageEvent extends LanguageEvent {
  final Country selectedCountry;

  ChangeSourceLanguageEvent(this.selectedCountry);
  List<Object> get props => [selectedCountry];
}

class ChangeTargetLanguageEvent extends LanguageEvent {
  final Country selectedCountry;

  ChangeTargetLanguageEvent(this.selectedCountry);
  List<Object> get props => [selectedCountry];
}
