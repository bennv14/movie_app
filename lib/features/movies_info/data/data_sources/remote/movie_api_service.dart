import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/constants/constants.dart';
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
    log(name: "MovieAPI", strUrl);
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
}
