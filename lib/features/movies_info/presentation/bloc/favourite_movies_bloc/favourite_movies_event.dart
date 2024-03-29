part of 'favourite_movies_bloc.dart';

abstract class FavouriteMoviesEvent extends Equatable {
  const FavouriteMoviesEvent();
}

class InitialFavouriteMovies extends FavouriteMoviesEvent {
  final DatabaseRepository _databaseRepository;

  const InitialFavouriteMovies(this._databaseRepository);

  @override
  List<Object> get props => [_databaseRepository];
}

class LogoutFavouriteMovies extends FavouriteMoviesEvent {
  @override
  List<Object> get props => [];
}

class AddFavouriteMovies extends FavouriteMoviesEvent {
  final MovieEntity movie;
  const AddFavouriteMovies(this.movie);
  @override
  List<Object?> get props => [movie];
}

class RemoveFavouriteMovies extends FavouriteMoviesEvent {
  final MovieEntity movie;
  const RemoveFavouriteMovies(this.movie);
  @override
  List<Object?> get props => [movie];
}
