import 'dart:developer';
import 'dart:io';

import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/data/data_sources/remote/movie_api_service.dart';
import 'package:movie_app/features/movies_info/data/models/genres_response.dart';
import 'package:movie_app/features/movies_info/data/models/movies_response.dart';
import 'package:movie_app/features/movies_info/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieAPISerVice _movieAPISerVice;

  MovieRepositoryImpl(this._movieAPISerVice);

  @override
  Future<DataState<MoviesResponse>> getMovies({
    String uri = uriNowPlaying,
    int curentPage = 1,
    String language = 'vi',
    String region = 'vn',
  }) async {
    try {
      MoviesResponse moviesResponse = await _movieAPISerVice.getMovies(
        uri: uri,
        curentPage: curentPage,
        language: language,
        region: region,
      );

      if (moviesResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(moviesResponse);
      } else {
        return DataFailed(
          Exception(
            "HTTP status code: ",
          ),
        );
      }
    } on Exception catch (e) {
      log(e.toString(), name: "GetMoviesUseCase");
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<GenresResponse>> getGenres({String language = 'vi'}) async {
    try {
      final genresResponse = await _movieAPISerVice.getAllGenres(language: language);
      if (genresResponse.response.statusCode == 200) {
        return DataSuccess(genresResponse);
      }
      return DataFailed(
        Exception("HTTP status code: ${genresResponse.response.statusCode}"),
      );
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }
}
