part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class ResgisterSuccess extends RegisterState {
  final User user;

  const ResgisterSuccess(this.user);
}

class RegisterFailure extends RegisterState {
  final String message;
  final Exception exception;
  const RegisterFailure({required this.message, required this.exception});
}
