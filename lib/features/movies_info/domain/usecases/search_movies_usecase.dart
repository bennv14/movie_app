import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movies_info/data/dto/my_response.dart';
import 'package:movie_app/features/movies_info/data/dto/search_movies_request.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_info/domain/repository/movie_repository.dart';

class SearchMoviesUseCase
    implements UseCase<DataState<MyResponse<List<MovieEntity>>>, SearchMoviesRequest> {
  final MovieRepository _movieRepository;

  const SearchMoviesUseCase(this._movieRepository);

  @override
  Future<DataState<MyResponse<List<MovieEntity>>>> call({
    SearchMoviesRequest params = const SearchMoviesRequest(query: '', page: 0),
  }) async {
    return await _movieRepository.searchMovies(request: params);
  }
}
