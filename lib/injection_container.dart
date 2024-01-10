import 'package:http/http.dart' as http;

import 'package:get_it/get_it.dart';
import 'package:movie_app/features/movies_info/data/data_sources/remote/movie_api_service.dart';
import 'package:movie_app/features/movies_info/data/repository/movie_repository_impl.dart';
import 'package:movie_app/features/movies_info/domain/repository/movie_repository.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_genres_usecase.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_movies_usecase.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/genres_bloc/genres_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/movies_bloc/movies_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  //register http.client
  getIt.registerSingleton<http.Client>(http.Client());

  //register MovieAPIService
  getIt.registerSingleton<MovieAPISerVice>(MovieAPISerVice(getIt.get<http.Client>()));

  //register repository
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      getIt.get<MovieAPISerVice>(),
    ),
  );

  //register usecase
  getIt.registerLazySingleton<GetMoviesUseCase>(
    () => GetMoviesUseCase(getIt.get<MovieRepository>()),
  );

  getIt.registerLazySingleton<GetGenresUseCase>(
    () => GetGenresUseCase(getIt.get<MovieRepository>()),
  );

  //register bloc
  getIt.registerLazySingleton<MoviesBloc>(
    () => MoviesBloc(getIt.get<GetMoviesUseCase>()),
  );

  getIt.registerLazySingleton<GenresBloc>(
    () => GenresBloc(getIt.get<GetGenresUseCase>()),
  );
}
