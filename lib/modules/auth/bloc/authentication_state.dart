part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {
  final bool isLoading;

  const AuthenticationLoadingState({required this.isLoading});
}

class AuthenticationSuccessState extends AuthenticationState {
  final UserModel user;
  final String message;
  const AuthenticationSuccessState(this.user, this.message);
  @override
  List<Object> get props => [user];
}

class AuthenticationFailureState extends AuthenticationState {
  final String errorMessage;

  const AuthenticationFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
