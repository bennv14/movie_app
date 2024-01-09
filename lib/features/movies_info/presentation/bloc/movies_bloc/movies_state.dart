part of 'movies_bloc.dart';

enum MoviesStatus { initial, success, failure, waiting }

class MoviesState extends Equatable {
  final MoviesStatus status;
  final List<MovieEntity> movies;
  final bool hasReachedMax;
  final int currentPage;
  final String uri;

  const MoviesState({
    this.status = MoviesStatus.initial,
    this.movies = const <MovieEntity>[],
    this.hasReachedMax = false,
    this.currentPage = 0,
    this.uri = uriNowPlaying,
  });

  MoviesState copyWith({
    MoviesStatus? status,
    List<MovieEntity>? movies,
    bool? hasReachedMax,
    String? uri,
    int? currentPage,
  }) {
    return MoviesState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      uri: uri ?? this.uri,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [status, movies, hasReachedMax, currentPage, uri];
}
