import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movies_info/data/dto/my_response.dart';
import 'package:movie_app/features/movies_info/data/models/genre_model.dart';
import 'package:movie_app/features/movies_info/domain/repository/movie_repository.dart';

class GetGenresUseCase
    implements UseCase<DataState<MyResponse<List<GenreModel>>>, String> {
  final MovieRepository _movieRepository;

  const GetGenresUseCase(this._movieRepository);
  @override
  Future<DataState<MyResponse<List<GenreModel>>>> call({String params = 'vi'}) async {
    return await _movieRepository.getGenres(language: params);
  }
}
