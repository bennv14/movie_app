import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movies_info/data/dto/movie_request.dart';
import 'package:movie_app/features/movies_info/data/dto/my_response.dart';
import 'package:movie_app/features/movies_info/domain/entities/review_entity.dart';
import 'package:movie_app/features/movies_info/domain/repository/movie_repository.dart';

class GetReviewsMovieUseCase
    implements UseCase<DataState<MyResponse<List<ReviewEntity>>>, MovieRequest> {
  final MovieRepository _movieRepository;

  const GetReviewsMovieUseCase(this._movieRepository);

  @override
  Future<DataState<MyResponse<List<ReviewEntity>>>> call({
    MovieRequest params = const MovieRequest(id: 0, page: 0),
  }) async {
    return await _movieRepository.getReviewsMovie(
      id: params.id,
      page: params.page,
    );
  }
}
