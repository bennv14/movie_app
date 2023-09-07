import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/cast.dart';
import 'package:movie_app/models/genre.dart';
import 'package:movie_app/models/movie.dart';

class API {
  static const String url = "https://api.themoviedb.org/";
  static const String apiKey = "87bb1e74c2449ef81ef90b13af3299e9";
  static const String assetTokenAuth =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4N2JiMWU3NGMyNDQ5ZWY4MWVmOTBiMTNhZjMyOTllOSIsInN1YiI6IjY0ZTk5MzllZWE4OWY1MDEzYjE4MmZlNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GwJ4LoIFhtrzZA83LgoiYPux_Mky3pSoG0T0HmcohJM";
  static const String uriNowPlaying = "3/movie/now_playing";
  static const String uriPopular = "3/movie/popular";
  static const String uriTopRate = "3/movie/top_rated";
  static const String uriUpcomming = "3/movie/upcoming";
  static const String uriListGenres = "3/genre/movie/list";
  static const String urlImage = "https://image.tmdb.org/t/p/w500";
  static const String uriMovieDetail = "3/movie/";
  static const String languageRegion = "?language=vi&region=vn";
  static const String appendCasts = "&append_to_response=casts";
  static const Map<String, String> headers = <String, String>{
    'Accept': 'application/json',
    'Authorization': 'Bearer $assetTokenAuth',
  };

  static String? makeUlrImage(String? imgPath) {
    if (imgPath == null) {
      return null;
    }
    return "$urlImage$imgPath?api_key=$apiKey";
  }

  static String makeUrlCreditsMovie(int id) {
    return "${url}3/movie/$id/credits?langue=vi";
  }

  static String makeUrlReviewsMovie(int id) {
    return "${url}3/movie$id/reviews";
  }

  static Future<List<Genre>> getAllGenres() async {
    log(name: "API.getListGenres", "call");

    final response = await http.get(
      Uri.parse("$url$uriListGenres$languageRegion"),
      headers: headers,
    );
    List<Genre> genres = [];
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body);
      for (final data in decodeData["genres"]) {
        genres.add(Genre.fromJson(data));
      }
      log(name: "API.getListGenres", "${genres.length}");
      return genres;
    } else {
      throw Exception("Fail getListGenres");
    }
  }

  static Future<List<Movie>> getMovieNowPlaying() async {
    log(name: "API.getMovieNowPlaying", "call");
    List<Movie> movies = [];
    final response = await http.get(
      Uri.parse("$url$uriNowPlaying$languageRegion"),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body);
      for (final data in decodeData["results"]) {
        var movie = Movie.importantDetail(data);
        movies.add(movie);
      }
      log(name: "API.getMovieNowPlaying", "${movies.length}");
      return movies;
    } else {
      throw Exception("Fail getMovieNowPlaying");
    }
  }

  static Future<List<Movie>> getMoviePopular() async {
    log(name: "API.getMoviePopular", "call");
    List<Movie> movies = [];
    final response = await http.get(
      Uri.parse("$url$uriPopular?languge=vi&region=vn"),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body);
      for (final data in decodeData["results"].sublist(0, 5)) {
        var movie = Movie.importantDetail(data);
        movies.add(movie);
        log(name: "API.getMoviePopular", "Movie: $movie");
      }
      log(name: "API.getMoviePopular", "${movies.length}");
      return movies;
    } else {
      throw Exception("Fail getMoviePopular");
    }
  }

  static Future<List<Movie>> getMovieTopRate() async {
    log(name: "API.getMovieTopRate", "call");
    List<Movie> movies = [];
    final response = await http.get(
      Uri.parse("$url$uriTopRate$languageRegion"),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body);
      for (final data in decodeData["results"]) {
        var movie = Movie.importantDetail(data);
        movies.add(movie);
        log(name: "API.getMovieTopRate", "Movie: $movie");
      }
      log(name: "API.getMovieTopRate", "${movies.length}");
      return movies;
    } else {
      throw Exception("Fail getMovieTopRate");
    }
  }

  static Future<List<Movie>> getMovieUpcoming() async {
    log(name: "API.getMovieUpcoming", "call");
    List<Movie> movies = [];
    final response = await http.get(
      Uri.parse("$url$uriUpcomming$languageRegion"),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body);
      for (final data in decodeData["results"]) {
        var movie = Movie.importantDetail(data);
        movies.add(movie);
      }
      log(name: "API.getMovieUpcoming", "${movies.length}");
      return movies;
    } else {
      throw Exception("Fail getMovieUpcoming");
    }
  }

  static Future<Movie> getFullDetailMovie(Movie movie) async {
    final response = await http.get(
      Uri.parse("$url$uriMovieDetail${movie.id}$appendCasts$languageRegion"),
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

  static Future<List<Cast>> getCastsMovie(int id) async {
    List<Cast> casts = <Cast>[];
    final response = await http.get(
      Uri.parse(makeUrlCreditsMovie(id)),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body);
      for (var data in decodeData["cast"]) {
        casts.add(Cast.fromJson(data));
      }
    } else {
      throw Exception("Fail getCastsMovie");
    }

    return casts;
  }
}
