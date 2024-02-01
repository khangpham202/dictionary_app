import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/authentication.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService authService = AuthService();
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {
      on<SignUp>((event, emit) async {
        emit(const AuthenticationLoadingState(isLoading: true));
        try {
          await authService.signUp(event.email, event.password, event.fullName);
          emit(const AuthenticationSuccessState('Sign up successfully'));
        } on FirebaseAuthException catch (e) {
          if (event.email.trim() == '' && event.password.trim() == '') {
            emit(const AuthenticationFailureState('Field cannot be empty!!'));
          } else {
            emit(AuthenticationFailureState(e.message!));
          }
        }
        emit(const AuthenticationLoadingState(isLoading: false));
      });
      on<Login>((event, emit) async {
        emit(const AuthenticationLoadingState(isLoading: true));
        try {
          await authService.signIn(event.email, event.password);
          emit(const AuthenticationSuccessState('Sign in successfully'));
        } on FirebaseAuthException catch (e) {
          if (event.email.trim() == '' || event.password.trim() == '') {
            emit(const AuthenticationFailureState('Field cannot be empty!!'));
          } else {
            emit(AuthenticationFailureState(e.toString()));
          }
        }
        emit(const AuthenticationLoadingState(isLoading: false));
      });
      on<SignOut>((event, emit) async {
        emit(const AuthenticationLoadingState(isLoading: true));
        try {
          authService.signOut();
          ;
        } catch (e) {
          emit(AuthenticationFailureState(e.toString()));
        }
        emit(const AuthenticationLoadingState(isLoading: false));
      });
    });
  }
}
