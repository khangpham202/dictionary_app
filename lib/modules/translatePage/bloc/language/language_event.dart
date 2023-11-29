part of 'language_bloc.dart';

sealed class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class ChangeLanguageEvent extends LanguageEvent {
  final String sourceLanguage;
  final String targetLanguage;

  const ChangeLanguageEvent({
    required this.sourceLanguage,
    required this.targetLanguage,
  });
  @override
  List<Object> get props => [sourceLanguage, targetLanguage];
}
