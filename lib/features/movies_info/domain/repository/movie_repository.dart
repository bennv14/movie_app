import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/data/models/genres_response.dart';
import 'package:movie_app/features/movies_info/data/models/movies_response.dart';

abstract class MovieRepository {
  Future<DataState<MoviesResponse>> getMovies({
    String uri = uriNowPlaying,
    int curentPage = 1,
    String language = 'vi',
    String region = 'vn',
  });

  Future<DataState<GenresResponse>> getGenres({String language = 'vi'});
}
