import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';

abstract class DatabaseRepository {
  Future addFavouriteMovie(MovieEntity movie);
  Future<DataState<List<MovieEntity>>> getFavouriteMovies();
  Future removeFavouriteMovie(MovieEntity movie);
}
