import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_info/domain/repository/database_repository.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_favourite_movies_usecase.dart';
import 'package:movie_app/injection_container.dart';

class FavouriteMovies {
  List<MovieEntity> _movies = [];
  static final FavouriteMovies _instance = FavouriteMovies._();

  static FavouriteMovies get instance => _instance;
  List<MovieEntity> get movies => _movies;

  FavouriteMovies._();

  Future<void> getFavouriteMovies() async {
    final dataState = await getIt.get<GetFavouriteMoviesUsecase>()();
    if (dataState is DataSuccess) {
      _movies = dataState.data!;
    } else {
      _movies = [];
    }
  }

  Future<void> addFavouriteMovies(MovieEntity movie) async {
    await getIt.get<DatabaseRepository>().addFavouriteMovie(movie);
  }
}
