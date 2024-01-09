import 'package:http/http.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';

class MoviesResponse {
  final Response response;
  final List<MovieEntity>? movies;
  final int? totalPage;
  final int? curentPage;

  const MoviesResponse({
    required this.response,
    this.movies,
    this.totalPage,
    this.curentPage,
  });
}
