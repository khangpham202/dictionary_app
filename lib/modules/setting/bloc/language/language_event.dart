part of 'language_bloc.dart';

sealed class CountryLanguageEvent extends Equatable {
  const CountryLanguageEvent();

  @override
  List<Object> get props => [];
}

class ChangeLanguage extends CountryLanguageEvent {
  final Language selectedLanguage;

  const ChangeLanguage({
    required this.selectedLanguage,
  });

  @override
  List<Object> get props => [selectedLanguage];
}
