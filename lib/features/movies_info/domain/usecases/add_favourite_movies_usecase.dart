import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_info/domain/repository/database_repository.dart';

class AddFavouriteMoviesUsecase implements UseCase<void, MovieEntity> {
  final DatabaseRepository _databaseRepository;

  const AddFavouriteMoviesUsecase(this._databaseRepository);
  @override
  Future<void> call({MovieEntity params = const MovieEntity()}) async {
    await _databaseRepository.addFavouriteMovie(params);
  }
}
