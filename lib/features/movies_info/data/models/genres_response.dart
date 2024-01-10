import 'package:http/http.dart';
import 'package:movie_app/features/movies_info/data/models/genre_model.dart';

class GenresResponse {
  final Response response;
  final List<GenreModel>? genres;

  const GenresResponse({required this.response, this.genres});
}
