part of 'language_bloc.dart';

sealed class LanguageState extends Equatable {
  final Language language;

  const LanguageState(this.language);

  @override
  List<Object> get props => [language];
}

class LanguageSelected extends LanguageState {
  const LanguageSelected(Language language) : super(language);
}
