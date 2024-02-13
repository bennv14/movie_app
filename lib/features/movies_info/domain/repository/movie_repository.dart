import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/data/dto/movie_image.dart';
import 'package:movie_app/features/movies_info/data/dto/my_response.dart';
import 'package:movie_app/features/movies_info/data/dto/search_movies_request.dart';
import 'package:movie_app/features/movies_info/data/models/genre_model.dart';
import 'package:movie_app/features/movies_info/data/models/movie_model.dart';
import 'package:movie_app/features/movies_info/domain/entities/cast_entity.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_info/domain/entities/review_entity.dart';

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

  Future<DataState<MyResponse<ImagesMovie>>> getImagesMovie({required int id});

  Future<DataState<MyResponse<List<CastEntity>>>> getCastMovie({
    required int id,
    String language = 'vi',
  });

  Future<DataState<MyResponse<List<ReviewEntity>>>> getReviewsMovie({
    required int id,
    int page = 1,
  });

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

  Future<DataState<MyResponse<List<MovieEntity>>>> searchMovies({
    required SearchMoviesRequest request,
  });
}
