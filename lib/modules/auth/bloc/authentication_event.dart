part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignUp extends AuthenticationEvent {
  final String fullName;
  final String email;
  final String password;

  const SignUp(this.fullName, this.email, this.password);

  @override
  List<Object> get props => [fullName, email, password];
}

class Login extends AuthenticationEvent {
  final String email;
  final String password;

  const Login(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignOut extends AuthenticationEvent {}
