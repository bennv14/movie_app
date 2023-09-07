part of 'movies_bloc.dart';

enum MoviesStatus { initial, success, failure, waiting }

class MoviesState extends Equatable {
  final MoviesStatus status;
  final List<Movie> movies;
  final bool hasReachedMax;

  const MoviesState({
    this.status = MoviesStatus.initial,
    this.movies = const <Movie>[],
    this.hasReachedMax = false,
  });

  MoviesState copyWith({
    Function? funcFetch,
    MoviesStatus? status,
    List<Movie>? movies,
    bool? hasReachedMax,
  }) {
    return MoviesState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, movies, hasReachedMax];
}
