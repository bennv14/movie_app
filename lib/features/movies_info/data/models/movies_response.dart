import 'package:http/http.dart';
import 'package:movie_app/features/movies_info/data/models/movie_model.dart';

class MoviesResponse {
  final Response response;
  final List<MovieModel>? movies;
  final int? totalPage;
  final int? curentPage;

  const MoviesResponse({
    required this.response,
    this.movies,
    this.totalPage,
    this.curentPage,
  });
}
