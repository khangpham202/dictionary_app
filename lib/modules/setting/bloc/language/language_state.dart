part of 'language_bloc.dart';

class CountryLanguageState extends Equatable {
  const CountryLanguageState({
    Language? selectedLanguage,
  }) : selectedLanguage = selectedLanguage ?? Language.greek;

  final Language selectedLanguage;

  @override
  List<Object> get props => [selectedLanguage];

  CountryLanguageState copyWith({Language? selectedLanguage}) {
    return CountryLanguageState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}
