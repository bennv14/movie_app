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

class ChangeFuncFetchMovies extends MoviesEvent {
  final Function funFetch;
  ChangeFuncFetchMovies({required this.funFetch});

  @override
  List<Object?> get props => [funFetch];
}
