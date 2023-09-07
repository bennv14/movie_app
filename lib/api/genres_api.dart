import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/genre.dart';

class GenresAPI {
  static const String url = "https://api.themoviedb.org/3/genre/movie/list";
  static const String apiKey = "87bb1e74c2449ef81ef90b13af3299e9";
  static const String assetTokenAuth =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4N2JiMWU3NGMyNDQ5ZWY4MWVmOTBiMTNhZjMyOTllOSIsInN1YiI6IjY0ZTk5MzllZWE4OWY1MDEzYjE4MmZlNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GwJ4LoIFhtrzZA83LgoiYPux_Mky3pSoG0T0HmcohJM";

  static const Map<String, String> headers = <String, String>{
    'Accept': 'application/json',
    'Authorization': 'Bearer $assetTokenAuth',
  };

  static Future<List<Genre>> getAllGenres({String language = 'vi'}) async {
    log(name: "GenresAPI", "call");

    final response = await http.get(
      Uri.parse("$url?language=$language"),
      headers: headers,
    );
    List<Genre> genres = [];
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body);
      for (final data in decodeData["genres"]) {
        genres.add(Genre.fromJson(data));
      }
      log(name: "GenresAPI", "Length of genres ${genres.length}");
      return genres;
    } else {
      throw Exception("Fail getListGenres");
    }
  }
}
