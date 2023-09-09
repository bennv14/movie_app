import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie.dart';

class MoviesAPI {
  static String url = "https://api.themoviedb.org/3";
  static const String assetTokenAuth =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4N2JiMWU3NGMyNDQ5ZWY4MWVmOTBiMTNhZjMyOTllOSIsInN1YiI6IjY0ZTk5MzllZWE4OWY1MDEzYjE4MmZlNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GwJ4LoIFhtrzZA83LgoiYPux_Mky3pSoG0T0HmcohJM";
  static const String uriNowPlaying = "/movie/now_playing";
  static const String uriPopular = "/movie/popular";
  static const String uriTopRate = "/movie/top_rated";
  static const String uriUpcomming = "/movie/upcoming";

  static const Map<String, String> headers = <String, String>{
    'Accept': 'application/json',
    'Authorization': 'Bearer $assetTokenAuth',
  };

  static Function getMovies({
    required String uri,
    int curentPage = 1,
    String language = 'vi',
    String region = 'vn',
  }) {
    log(name: "MovieAPI", "func get movies call");
    int totalPages = 1;

    Future<List<Movie>> funcResult() async {
      log(name: "MovieAPI", " get movies");
      List<Movie> movies = [];

      if (curentPage <= totalPages) {
        String strUrl = "$url$uri?language=$language&page=$curentPage&region=$region";

        final response = await http.get(Uri.parse(strUrl), headers: headers);

        if (response.statusCode == 200) {
          final decodeData = json.decode(response.body);
          totalPages = decodeData["total_pages"];
          curentPage++;
          for (final data in decodeData["results"]) {
            var movie = Movie.importantDetail(data);
            movies.add(movie);
          }
          log(name: "MovieAPI", " Length of movies ${movies.length}");

          return movies;
        } else {
          throw Exception("ListMovieApi Fail");
        }
      } else {
        return movies;
      }
    }

    return funcResult;
  }
}
