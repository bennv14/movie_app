part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthEvent {
  final AuthStrategy authStrategy;
  final User user;

  const LoggedIn(this.user, {required this.authStrategy});

  @override
  List<Object> get props => [user, authStrategy];
}

class Login extends AuthEvent {
  final AuthStrategy authStrategy;
  const Login(this.authStrategy);

  @override
  List<Object> get props => [authStrategy];
}

class LogInByGoogle extends AuthEvent {}

class Logout extends AuthEvent {}
