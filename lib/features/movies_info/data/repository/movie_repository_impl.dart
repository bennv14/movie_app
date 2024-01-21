import 'dart:developer';
import 'dart:io';

import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/data/data_sources/remote/movie_api_service.dart';
import 'package:movie_app/features/movies_info/data/models/genre_model.dart';
import 'package:movie_app/features/movies_info/data/models/movie_model.dart';
import 'package:movie_app/features/movies_info/data/models/my_response.dart';
import 'package:movie_app/features/movies_info/data/models/search_movies_request.dart';
import 'package:movie_app/features/movies_info/domain/entities/cast_entity.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_info/domain/entities/review_entity.dart';
import 'package:movie_app/features/movies_info/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieAPISerVice _movieAPISerVice;

  MovieRepositoryImpl(this._movieAPISerVice);

  @override
  Future<DataState<MyResponse<List<MovieModel>>>> getMovies({
    String uri = uriNowPlaying,
    int page = 1,
    String language = 'vi',
    String region = 'vn',
  }) async {
    try {
      final dataState = await _movieAPISerVice.getMovies(
        uri: uri,
        page: page,
        language: language,
        region: region,
      );

      if (dataState.response.statusCode == HttpStatus.ok) {
        return DataSuccess(dataState);
      } else {
        return DataFailed(
          Exception(
            "getMovies status code: ${dataState.response.statusCode}"
          ),
        );
      }
    } on Exception catch (e) {
      log(e.toString(), name: "GetMoviesUseCase");
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<MyResponse<List<GenreModel>>>> getGenres({
    String language = 'vi',
  }) async {
    try {
      final genresResponse = await _movieAPISerVice.getAllGenres(language: language);
      if (genresResponse.response.statusCode == 200) {
        return DataSuccess(genresResponse);
      }
      return DataFailed(
        Exception("getGenre status code: ${genresResponse.response.statusCode}"),
      );
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<MyResponse<MovieModel>>> getMovieDetails({required int id}) async {
    try {
      final response = await _movieAPISerVice.getDetailsMovie(id: id);
      if (response.response.statusCode == 200) {
        return DataSuccess(response);
      }
      return DataFailed(Exception("getDetails status code: ${response.response.statusCode}"));
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<MyResponse<List<MovieModel>>>> getSimilarMovies({
    required int id,
    int page = 1,
    String language = 'vi',
  }) async {
    try {
      final dataState = await _movieAPISerVice.getSimilarMovies(
        id: id,
        page: page,
        language: language,
      );

      if (dataState.response.statusCode == HttpStatus.ok) {
        return DataSuccess(dataState);
      } else {
        return DataFailed(
          Exception(
            "getSimilar status code: ${dataState.response.statusCode}"
          ),
        );
      }
    } on Exception catch (e) {
      log(e.toString(), name: "GetSimilarMoviesUseCase");
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<MyResponse<List<MovieModel>>>> getRecommendMovies({
    required int id,
    int page = 1,
    String language = 'vi',
  }) async {
    try {
      final dataState = await _movieAPISerVice.getRecommendMovies(
        id: id,
        page: page,
        language: language,
      );

      if (dataState.response.statusCode == HttpStatus.ok) {
        return DataSuccess(dataState);
      } else {
        return DataFailed(
          Exception(
            "getRecommend status code: ${dataState.response.statusCode}"
          ),
        );
      }
    } on Exception catch (e) {
      log(e.toString(), name: "GetRecommendMoviesUseCase");
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<MyResponse<List<ReviewEntity>>>> getReviewsMovie({
    required int id,
    int page = 1,
  }) async {
    try {
      final myResponse = await _movieAPISerVice.getReviewsMovie(id: id, page: page);
      if (myResponse.response.statusCode == 200) {
        return DataSuccess(myResponse);
      } else {
        return DataFailed(
            Exception("getReviews status code: ${myResponse.response.statusCode}"));
      }
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<MyResponse<List<CastEntity>>>> getCastMovie({required int id, String language = 'vi',}) async{
    try {
      final myResponse = await _movieAPISerVice.getCastsMovie(id: id, language: language);
      if (myResponse.response.statusCode == 200) {
        return DataSuccess(myResponse);
      } else {
        return DataFailed(
            Exception("getCasts status code: ${myResponse.response.statusCode}"));
      }
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<MyResponse<List<MovieEntity>>>> searchMovies({required SearchMoviesRequest request,}) async {
    try {
      final myResponse = await _movieAPISerVice.searchMovies(request: request);
      if (myResponse.response.statusCode == 200) {
        return DataSuccess(myResponse);
      } else {
        return DataFailed(
            Exception("getCasts status code: ${myResponse.response.statusCode}"));
      }
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }
}
