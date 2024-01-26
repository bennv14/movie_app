import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_info/domain/repository/database_repository.dart';

class GetFavouriteMoviesUsecase implements UseCase<DataState<List<MovieEntity>>, void> {
  final DatabaseRepository _databaseRepository;

  const GetFavouriteMoviesUsecase(this._databaseRepository);
  @override
  Future<DataState<List<MovieEntity>>> call({void params}) async {
    return await _databaseRepository.getFavouriteMovies();
  }
}
