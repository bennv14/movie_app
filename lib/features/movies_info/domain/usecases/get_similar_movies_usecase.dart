import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movies_info/data/dto/movie_request.dart';
import 'package:movie_app/features/movies_info/data/dto/my_response.dart';
import 'package:movie_app/features/movies_info/data/models/movie_model.dart';
import 'package:movie_app/features/movies_info/domain/repository/movie_repository.dart';

class GetSimilarMoviesUseCase
    implements UseCase<DataState<MyResponse<List<MovieModel>>>, MovieRequest> {
  final MovieRepository _movieRepository;

  const GetSimilarMoviesUseCase(this._movieRepository);

  @override
  Future<DataState<MyResponse<List<MovieModel>>>> call({
    MovieRequest params = const MovieRequest(id: 0, page: 0),
  }) async {
    return await _movieRepository.getSimilarMovies(
      id: params.id,
      page: params.page,
    );
  }
}
