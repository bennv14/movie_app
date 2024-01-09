part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {}

class InitMovies extends MoviesEvent {
  @override
  List<Object?> get props => [];
}

class FetchMovies extends MoviesEvent {
  @override
  List<Object?> get props => [];
}

class ChangeURI extends MoviesEvent {
  final String uri;
  ChangeURI({required this.uri});

  @override
  List<Object?> get props => [uri];
}
