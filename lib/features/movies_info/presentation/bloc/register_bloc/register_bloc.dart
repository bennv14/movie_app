import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/firebase_auth_exception_code.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/data/models/account.dart';
import 'package:movie_app/features/movies_info/domain/usecases/register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUsecase _registerUsecase;
  RegisterBloc(this._registerUsecase) : super(RegisterInitial()) {
    on<Register>(_onRegister);
  }

  FutureOr<void> _onRegister(Register event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      final dataState = await _registerUsecase(params: event.account);
      if (dataState is DataSuccess && dataState.data != null) {
        emit(ResgisterSuccess(dataState.data!));
      } else {
        emit(
          RegisterFailure(
            message: "Unknow error",
            exception: Exception(),
          ),
        );
      }
    } on FirebaseException catch (e) {
      if (e.code == FirebaseAuthExceptionCode.emailAlreadyInUse) {
        emit(
          RegisterFailure(
            message: "Email already in use",
            exception: e,
          ),
        );
      } else if (e.code == FirebaseAuthExceptionCode.weakPassword) {
        emit(
          RegisterFailure(
            message: "Password is too weak",
            exception: e,
          ),
        );
      } else {
        emit(
          RegisterFailure(
            message: "Unknown error",
            exception: e,
          ),
        );
      }
    }
  }
}
