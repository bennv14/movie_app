import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movies_info/data/dto/movie_image.dart';
import 'package:movie_app/features/movies_info/data/dto/my_response.dart';
import 'package:movie_app/features/movies_info/domain/repository/movie_repository.dart';

class GetImagesMovieUsecase implements UseCase<DataState<MyResponse<ImagesMovie>>, int> {
  final MovieRepository _movieRepository;
  GetImagesMovieUsecase(this._movieRepository);
  @override
  Future<DataState<MyResponse<ImagesMovie>>> call({int params = 0}) async {
    return await _movieRepository.getImagesMovie(id: params);
  }
}
