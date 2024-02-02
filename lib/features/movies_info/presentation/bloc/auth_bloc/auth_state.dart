part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final User user;
  const Authenticated(this.user);

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthState {}

class AuthenticationLoading extends AuthState {}


class AuthenticationFailure extends AuthState {
  final String message;
  final Exception exception;
  const AuthenticationFailure({required this.message, required this.exception});
  @override
  List<Object> get props => [message, exception];
}
