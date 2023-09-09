import 'dart:convert';
import 'dart:developer';
import 'package:movie_app/models/cast.dart';
import 'package:movie_app/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/review.dart';

class MovieAPI {
  static String url = "https://api.themoviedb.org/3/movie/";
  static const String assetTokenAuth =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4N2JiMWU3NGMyNDQ5ZWY4MWVmOTBiMTNhZjMyOTllOSIsInN1YiI6IjY0ZTk5MzllZWE4OWY1MDEzYjE4MmZlNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GwJ4LoIFhtrzZA83LgoiYPux_Mky3pSoG0T0HmcohJM";

  static const Map<String, String> headers = <String, String>{
    'Accept': 'application/json',
    'Authorization': 'Bearer $assetTokenAuth',
  };

  static Future<Movie> getDetails({
    required int id,
    String language = 'vi',
  }) async {
    final response = await http.get(
      Uri.parse("$url$id?language=$language"),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body);
      var movieDetail = Movie.fullDetail(decodeData);
      return movieDetail;
    } else {
      throw Exception("Fail getFullDetailMovie");
    }
  }

  static Future<List<Cast>> getCasts({
    required int id,
    String language = 'vi',
  }) async {
    log(name: "MovieAPI", "getCasts");
    List<Cast> casts = <Cast>[];
    final response = await http.get(
      Uri.parse("$url$id/credits?language=$language"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body);
      for (var data in decodeData["cast"]) {
        casts.add(Cast.fromJson(data));
      }
      log(name: "MovieAPI", "Length of casts = ${casts.length}");
      return casts;
    } else {
      throw Exception("Fail getCastsMovie");
    }
  }

  static Function getReviews({
    required int id,
    int curentPage = 1,
    String language = 'en',
  }) {
    int totalPages = 1;
    int totalResults = 0;

    Future<List> funcResult() async {
      List<Review> reviews = [];

      if (curentPage <= totalPages) {
        log(name: "MovieAPI", "getReviews");
        final response = await http.get(
          Uri.parse("$url$id/reviews?language=$language&page=$curentPage"),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final decodeData = json.decode(response.body);
          totalPages = decodeData["total_pages"];
          curentPage++;
          totalResults = decodeData["total_results"];

          for (var data in decodeData['results']) {
            reviews.add(Review.fromJson(data));
          }
          log(name: "MovieAPI", "Length of reviews = ${reviews.length}");
          return [totalResults, reviews];
        } else {
          throw Exception("Fail getReviews statusCode = ${response.statusCode}");
        }
      }
      return [totalResults, reviews];
    }

    return funcResult;
  }
}
