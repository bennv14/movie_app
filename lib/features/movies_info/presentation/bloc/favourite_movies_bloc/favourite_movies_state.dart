part of 'favourite_movies_bloc.dart';

enum FavouriteMoviesStatus { init, success, loading, error }

class FavouriteMoviesState extends Equatable {
  final FavouriteMoviesStatus status;
  final List<MovieEntity> movies;

  const FavouriteMoviesState({
    this.status = FavouriteMoviesStatus.init,
    this.movies = const [],
  });

  FavouriteMoviesState copyWith({
    FavouriteMoviesStatus? status,
    List<MovieEntity>? movies,
  }) {
    return FavouriteMoviesState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
    );
  }

  @override
  List<Object> get props => [status, movies];
}
