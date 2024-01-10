import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movies_info/data/models/genres_response.dart';
import 'package:movie_app/features/movies_info/domain/repository/movie_repository.dart';

class GetGenresUseCase implements UseCase<DataState<GenresResponse>, String> {
  final MovieRepository _movieRepository;

  const GetGenresUseCase(this._movieRepository);
  @override
  Future<DataState<GenresResponse>> call({String params = 'vi'}) async {
    return _movieRepository.getGenres(language: params);
  }
}
