import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/data/models/genre_model.dart';
import 'package:movie_app/features/movies_info/data/models/movie_model.dart';
import 'package:movie_app/features/movies_info/data/models/my_response.dart';

abstract class MovieRepository {
  Future<DataState<MyResponse<List<MovieModel>>>> getMovies({
    String uri = uriNowPlaying,
    int page = 1,
    String language = 'vi',
    String region = 'vn',
  });

  Future<DataState<MyResponse<List<GenreModel>>>> getGenres({
    String language = 'vi',
  });

  Future<DataState<MyResponse<MovieModel>>> getMovieDetails({required int id});

  Future<DataState<MyResponse<List<MovieModel>>>> getSimilarMovies({
    required int id,
    int page = 1,
    String language = 'vi',
  });

  Future<DataState<MyResponse<List<MovieModel>>>> getRecommendMovies({
    required int id,
    int page = 1,
    String language = 'vi',
  });
}
