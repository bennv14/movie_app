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
    String language = 'vn',
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
    String language = 'en',
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

  static Future<List<Review>> getReviews({
    required int id,
    int page = 1,
    String language = 'en',
  }) async {
    List<Review> reviews = [];
    log(name: "MovieAPI", "getReviews");
    final response = await http.get(
      Uri.parse("$url$id/reviews?language=$language&page=$page"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body);
      for (var data in decodeData['results']) {
        reviews.add(Review.fromJson(data));
      }
      log(name: "MovieAPI", "Length of reviews = ${reviews.length}");
      return reviews;
    } else {
      throw Exception("Fail getReviews statusCode = ${response.statusCode}");
    }
  }
}
