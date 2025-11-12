import 'package:bloc/bloc.dart';

/// 4) LOGIN BLOC (async, multiple states)
abstract class LoginEvent {}

class LoginRequested extends LoginEvent {
  final String username;
  final String password;
  LoginRequested({required this.username, required this.password});
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;
  LoginSuccess(this.token);
}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (event.username == 'user' && event.password == 'pass') {
        emit(LoginSuccess('fake-token-123'));
      } else {
        emit(LoginFailure('Invalid credentials'));
      }
    } catch (e, st) {
      emit(LoginFailure('Unexpected error'));
      addError(e, st);
    }
  }
}



