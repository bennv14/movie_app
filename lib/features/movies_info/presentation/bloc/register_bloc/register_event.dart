part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class Register extends RegisterEvent {
  final Account account;

  const Register(this.account);
}
