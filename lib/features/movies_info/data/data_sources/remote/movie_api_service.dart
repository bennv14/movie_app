import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/data/models/cast_model.dart';
import 'package:movie_app/features/movies_info/data/models/genre_model.dart';
import 'package:movie_app/features/movies_info/data/models/genres_response.dart';
import 'package:movie_app/features/movies_info/data/models/movie_model.dart';
import 'package:movie_app/features/movies_info/data/models/movies_response.dart';

class MovieAPISerVice {
  final http.Client client;
  MovieAPISerVice(this.client);

  Future<MoviesResponse> getMovies({
    String uri = uriNowPlaying,
    int curentPage = 1,
    String language = 'vi',
    String region = 'vn',
  }) async {
    String strUrl =
        "$movieBaseURL$uri?language=$language&page=$curentPage&region=$region";
    log(name: "MovieAPISerVice", "getMovies: $strUrl");
    final response = await client.get(Uri.parse(strUrl), headers: headers);

    final decodeData = json.decode(response.body);
    final totalPages = decodeData["total_pages"];
    final List<MovieModel> movies = [];
    for (final data in decodeData["results"]) {
      final movie = MovieModel.fromJson(data);
      movies.add(movie);
    }
    log(movies.toString());
    log(name: "MovieAPI", " Length of movies ${movies.length}");

    return MoviesResponse(
      movies: movies,
      response: response,
      totalPage: totalPages,
      curentPage: curentPage,
    );
  }

  Future<GenresResponse> getAllGenres({String language = 'vi'}) async {
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
      return GenresResponse(response: response, genres: genres);
    } else {
      throw Exception("Fail getListGenres");
    }
  }

  Future<List<CastModel>> getCasts({
    required int id,
    String language = 'vi',
  }) async {
    log(name: "MovieAPISerVice", "getCasts");
    List<CastModel> casts = <CastModel>[];
    final response = await http.get(
      Uri.parse("$movieBaseURL$id/credits?language=$language"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body);
      for (var data in decodeData["cast"]) {
        casts.add(CastModel.fromJson(data));
      }
      log(name: "MovieAPISerVice", "Length of casts = ${casts.length}");
      return casts;
    } else {
      throw Exception("Fail getCastsMovie");
    }
  }
}
