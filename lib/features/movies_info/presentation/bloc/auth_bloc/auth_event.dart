part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthEvent {
  final User user;

  const LoggedIn(this.user);

  @override
  List<Object> get props => [user];
}

class Login extends AuthEvent {
  final Account account;
  const Login(this.account);

  @override
  List<Object> get props => [account];
}

class Logout extends AuthEvent {}
