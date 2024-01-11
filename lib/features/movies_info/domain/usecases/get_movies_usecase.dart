import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movies_info/data/models/movie_model.dart';
import 'package:movie_app/features/movies_info/data/models/movies_request.dart';
import 'package:movie_app/features/movies_info/data/models/my_response.dart';
import 'package:movie_app/features/movies_info/domain/repository/movie_repository.dart';

class GetMoviesUseCase
    implements UseCase<DataState<MyResponse<List<MovieModel>>>, MoviesRequest> {
  final MovieRepository _movieRepository;

  GetMoviesUseCase(this._movieRepository);

  @override
  Future<DataState<MyResponse<List<MovieModel>>>> call({
    MoviesRequest params = const MoviesRequest(
      uri: uriNowPlaying,
      curentPage: 1,
    ),
  }) async {
    return await _movieRepository.getMovies(
      uri: params.uri,
      curentPage: params.curentPage,
    );
  }
}
