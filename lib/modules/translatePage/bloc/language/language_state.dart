part of 'language_bloc.dart';

sealed class LanguageState extends Equatable {
  final String sourceLanguage;
  final String targetLanguage;

  const LanguageState({
    required this.sourceLanguage,
    required this.targetLanguage,
  });

  @override
  List<Object?> get props => [sourceLanguage, targetLanguage];
}

class LanguageInitial extends LanguageState {
  const LanguageInitial({
    String sourceLanguage = 'English',
    String targetLanguage = 'Vietnamese',
  }) : super(sourceLanguage: sourceLanguage, targetLanguage: targetLanguage);
}
