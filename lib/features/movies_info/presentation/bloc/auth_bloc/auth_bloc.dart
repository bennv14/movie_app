import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/firebase_auth_exception_code.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/presentation/controller/auth_strategy/auth_strategy.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late AuthStrategy _authStrategy;
  AuthBloc() : super(Unauthenticated()) {
    on<Login>(_onLogin);
    on<Logout>(_onLogout);
    on<LoggedIn>(_onLoggedIn);
    on<Register>(_onRegister);
  }

  FutureOr<void> _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(AuthenticationLoading());
    try {
      _authStrategy = event.authStrategy;
      final dataState = await _authStrategy.login();
      if (dataState is DataSuccess && dataState.data != null) {
        emit(Authenticated(dataState.data!));
      } else {
        emit(
          AuthenticationFailure(
            message: "User not found",
            exception: Exception("Unknown"),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseAuthExceptionCode.userNotFound) {
        emit(
          AuthenticationFailure(
            message: "User not found",
            exception: e,
          ),
        );
      } else if (e.code == FirebaseAuthExceptionCode.wrongPassword) {
        emit(
          AuthenticationFailure(
            message: "Wrong password",
            exception: e,
          ),
        );
      } else if (e.code == FirebaseAuthExceptionCode.userDisable) {
        emit(
          AuthenticationFailure(
            message: "User is disabled",
            exception: e,
          ),
        );
      } else {
        emit(
          AuthenticationFailure(
            message: "Unknown error",
            exception: e,
          ),
        );
      }
    }
  }

  FutureOr<void> _onLogout(Logout event, Emitter<AuthState> emit) async {
    try {
      emit(AuthenticationLoading());
      await _authStrategy.logout();
      emit(Unauthenticated());
    } on Exception catch (e) {
      emit(
        AuthenticationFailure(
          message: "Unknown error",
          exception: e,
        ),
      );
    }
  }

  FutureOr<void> _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    _authStrategy = event.authStrategy;
    emit(Authenticated(event.user));
  }

  FutureOr<void> _onRegister(Register event, Emitter<AuthState> emit) async {
    emit(AuthenticationLoading());
    try {
      _authStrategy = event.authStrategy;
      final dataState = await _authStrategy.register();
      if (dataState is DataSuccess && dataState.data != null) {
        emit(Authenticated(dataState.data!));
      } else {
        emit(
          AuthenticationFailure(
            message: "User not found",
            exception: Exception("Unknown"),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseAuthExceptionCode.userNotFound) {
        emit(
          AuthenticationFailure(
            message: "User not found",
            exception: e,
          ),
        );
      } else if (e.code == FirebaseAuthExceptionCode.wrongPassword) {
        emit(
          AuthenticationFailure(
            message: "Wrong password",
            exception: e,
          ),
        );
      } else if (e.code == FirebaseAuthExceptionCode.userDisable) {
        emit(
          AuthenticationFailure(
            message: "User is disabled",
            exception: e,
          ),
        );
      } else {
        emit(
          AuthenticationFailure(
            message: "Unknown error",
            exception: e,
          ),
        );
      }
    }
  }
}
