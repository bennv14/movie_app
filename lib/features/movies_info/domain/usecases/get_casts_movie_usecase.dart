import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movies_info/data/models/movie_request.dart';
import 'package:movie_app/features/movies_info/data/models/my_response.dart';
import 'package:movie_app/features/movies_info/domain/entities/cast_entity.dart';
import 'package:movie_app/features/movies_info/domain/repository/movie_repository.dart';

class GetCastsMovieUseCase
    implements UseCase<DataState<MyResponse<List<CastEntity>>>, MovieRequest> {
  final MovieRepository _movieRepository;

  const GetCastsMovieUseCase(this._movieRepository);

  @override
  Future<DataState<MyResponse<List<CastEntity>>>> call({
    MovieRequest params = const MovieRequest(id: 0, page: 0),
  }) async {
    return await _movieRepository.getCastMovie(
      id: params.id,
      language: 'vi',
    );
  }
}
