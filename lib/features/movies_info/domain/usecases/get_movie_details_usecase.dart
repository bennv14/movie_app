import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movies_info/data/dto/my_response.dart';
import 'package:movie_app/features/movies_info/data/models/movie_model.dart';
import 'package:movie_app/features/movies_info/domain/repository/movie_repository.dart';

class GetMovieDetailsUseCase implements UseCase<DataState<MyResponse<MovieModel>>, int> {
  final MovieRepository _movieRepository;

  const GetMovieDetailsUseCase(this._movieRepository);

  @override
  Future<DataState<MyResponse<MovieModel>>> call({params = 0}) async {
    return await _movieRepository.getMovieDetails(id: params);
  }
}
