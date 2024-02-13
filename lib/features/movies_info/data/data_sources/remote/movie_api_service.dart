import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/data/dto/movie_image.dart';
import 'package:movie_app/features/movies_info/data/dto/my_response.dart';
import 'package:movie_app/features/movies_info/data/dto/search_movies_request.dart';
import 'package:movie_app/features/movies_info/data/models/cast_model.dart';
import 'package:movie_app/features/movies_info/data/models/genre_model.dart';
import 'package:movie_app/features/movies_info/data/models/image_model.dart';
import 'package:movie_app/features/movies_info/data/models/movie_model.dart';
import 'package:movie_app/features/movies_info/data/models/review_model.dart';
import 'package:movie_app/features/movies_info/domain/entities/cast_entity.dart';
import 'package:movie_app/features/movies_info/domain/entities/image_entity.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_info/domain/entities/review_entity.dart';

class MovieAPISerVice {
  final http.Client client;
  MovieAPISerVice(this.client);

  Future<MyResponse<List<MovieModel>>> getMovies({
    String uri = uriNowPlaying,
    int page = 1,
    String language = 'vi',
    String region = 'vn',
  }) async {
    String strUrl = "$movieBaseURL$uri?language=$language&page=$page&region=$region";
    log(name: "MovieAPISerVice", "getMovies: $strUrl");
    final response = await client.get(Uri.parse(strUrl), headers: headers);

    final decodeData = json.decode(response.body);
    final List<MovieModel> movies = [];
    for (final data in decodeData["results"]) {
      final movie = MovieModel.fromJson(data);
      movies.add(movie);
    }
    log(name: "MovieAPIService", " Length of movies ${movies.length}");

    return MyResponse<List<MovieModel>>(
      responseData: movies,
      response: response,
    );
  }

  Future<MyResponse<List<GenreModel>>> getAllGenres({String language = 'vi'}) async {
    log(name: "MovieAPISerVice", "getAllGenres");

    final response = await http.get(
      Uri.parse("$movieBaseURL$uriGenres?language=$language"),
      headers: headers,
    );
    List<GenreModel> genres = [];
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body);
      for (final data in decodeData["genres"]) {
        genres.add(GenreModel.fromJson(data));
      }
      log(name: "MovieAPISerVice", "Length of genres ${genres.length}");
      return MyResponse(
        response: response,
        responseData: genres,
      );
    } else {
      throw Exception("Fail getListGenres");
    }
  }

  Future<MyResponse<MovieModel>> getDetailsMovie({
    required int id,
    String language = 'vi',
  }) async {
    final response = await http.get(
      Uri.parse("$movieBaseURL$uriDetailMovie/$id?language=$language"),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body);
      var movie = MovieModel.fromJson(decodeData);
      return MyResponse(response: response, responseData: movie);
    } else {
      throw Exception("Fail getFullDetailMovie");
    }
  }

  Future<MyResponse<ImagesMovie>> getImagesMovie(
      {required int id, String language = 'en'}) async {
    final uri = Uri.parse("$movieBaseURL$uriDetailMovie/$id/images?language=$language");
    final response = await http.get(
      uri,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body);
      final List<ImageEntity> posters = [];
      for (final image in decodeData["posters"]) {
        posters.add(ImageModel.fromMap(image));
      }
      final List<ImageEntity> backdrops = [];
      for (final image in decodeData["backdrops"]) {
        backdrops.add(ImageModel.fromMap(image));
      }
      log(
        name: "getImagesMovie",
        "backdrops: ${backdrops.length} posters: ${posters.length}",
      );
      return MyResponse(
        response: response,
        responseData: ImagesMovie(posters: posters, backdrops: backdrops),
      );
    } else {
      throw Exception("Fail getImagesMovie");
    }
  }

  Future<MyResponse<List<CastEntity>>> getCastsMovie({
    required int id,
    String language = 'vi',
  }) async {
    log(name: "MovieAPISerVice", "getCasts");
    List<CastEntity> casts = [];
    final response = await http.get(
      Uri.parse("$movieBaseURL$uriDetailMovie/$id/credits?language=$language"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body);
      for (var data in decodeData["cast"]) {
        casts.add(CastModel.fromJson(data));
      }
      log(name: "MovieAPISerVice", "Length of casts = ${casts.length}");
      return MyResponse(response: response, responseData: casts);
    } else {
      throw Exception("Fail getCastsMovie");
    }
  }

  Future<MyResponse<List<ReviewEntity>>> getReviewsMovie(
      {required int id, int page = 1}) async {
    String url = "$movieBaseURL$uriDetailMovie/$id/reviews?page=$page";
    log(name: "MovieAPISerVice", "getReviewsMovie: $url");
    final response = await client.get(Uri.parse(url), headers: headers);
    final decodeData = json.decode(response.body);
    final List<ReviewModel> reviews = [];
    for (final data in decodeData['results']) {
      final review = ReviewModel.fromJson(data);
      reviews.add(review);
    }

    log(name: "MovieAPISerVice", "reviews: ${reviews.length}");
    return MyResponse(response: response, responseData: reviews);
  }

  Future<MyResponse<List<MovieModel>>> getSimilarMovies({
    required int id,
    int page = 1,
    String language = 'vi',
  }) async {
    String strUrl =
        "$movieBaseURL$uriDetailMovie/$id/similar?language=$language&page=$page";
    log(name: "MovieAPISerVice", "getSimilarMovies: $strUrl");
    final response = await client.get(Uri.parse(strUrl), headers: headers);

    final decodeData = json.decode(response.body);
    final List<MovieModel> movies = [];
    for (final data in decodeData["results"]) {
      final movie = MovieModel.fromJson(data);
      movies.add(movie);
    }
    log(name: "MovieAPISerVice", " similar length ${movies.length}");

    return MyResponse<List<MovieModel>>(
      responseData: movies,
      response: response,
    );
  }

  Future<MyResponse<List<MovieModel>>> getRecommendMovies({
    required int id,
    int page = 1,
    String language = 'vi',
  }) async {
    String strUrl =
        "$movieBaseURL$uriDetailMovie/$id/recommendations?language=$language&page=$page";
    log(name: "MovieAPISerVice", "getSimilarMovies: $strUrl");
    final response = await client.get(Uri.parse(strUrl), headers: headers);

    final decodeData = json.decode(response.body);
    final List<MovieModel> movies = [];
    for (final data in decodeData["results"]) {
      final movie = MovieModel.fromJson(data);
      movies.add(movie);
    }
    log(name: "MovieAPISerVice", " recommend length ${movies.length}");

    return MyResponse<List<MovieModel>>(
      responseData: movies,
      response: response,
    );
  }

  Future<MyResponse<List<MovieEntity>>> searchMovies({
    required SearchMoviesRequest request,
  }) async {
    String strUrl =
        "$movieBaseURL$uriSearchMovie?query=${request.query}&language=${request.language}&page=${request.page}&include_adult=true";
    log(name: "MovieAPISerVice", "searchMovies: $strUrl");
    final response = await client.get(Uri.parse(strUrl), headers: headers);

    final decodeData = json.decode(response.body);
    final List<MovieModel> movies = [];
    for (final data in decodeData["results"]) {
      final movie = MovieModel.fromJson(data);
      movies.add(movie);
    }
    log(name: "MovieAPISerVice", " search length ${movies.length}");

    return MyResponse<List<MovieModel>>(
      responseData: movies,
      response: response,
    );
  }
}
