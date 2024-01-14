import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training/core/common/model/user.dart';

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
          final UserModel? user = await authService.signUp(
              event.email, event.password, event.fullName);
          if (user != null) {
            emit(AuthenticationSuccessState(user, 'Sign up successfully!!'));
          } else {
            emit(const AuthenticationFailureState('create user failed'));
          }
        } catch (e) {
          emit(AuthenticationFailureState(e.toString()));
        }
        emit(const AuthenticationLoadingState(isLoading: false));
      });
      on<Login>((event, emit) async {
        emit(const AuthenticationLoadingState(isLoading: true));
        try {
          await authService.signIn(event.email, event.password);
        } catch (e) {
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
        } catch (e) {
          emit(AuthenticationFailureState(e.toString()));
        }
        emit(const AuthenticationLoadingState(isLoading: false));
      });
    });
  }
}
