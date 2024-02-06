part of 'country_bloc.dart';

sealed class LanguageState extends Equatable {
  final Country country;

  const LanguageState(this.country);

  @override
  List<Object> get props => [country];
}

class LanguageSelected extends LanguageState {
  const LanguageSelected(Country country) : super(country);
}
