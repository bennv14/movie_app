import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/features/movies_info/data/data_sources/remote/movie_api_service.dart';
import 'package:movie_app/features/movies_info/data/repository/firebase_auth_repository.dart';
import 'package:movie_app/features/movies_info/data/repository/movie_repository_impl.dart';
import 'package:movie_app/features/movies_info/domain/repository/movie_repository.dart';
import 'package:movie_app/features/movies_info/domain/usecases/add_favourite_movies_usecase.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_casts_movie_usecase.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_favourite_movies_usecase.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_genres_usecase.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_images_movies_usecase.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_movie_details_usecase.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_movies_usecase.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_recommend_movies_usecase.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_reviews_movie_usecase.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_similar_movies_usecase.dart';
import 'package:movie_app/features/movies_info/domain/usecases/register_usecase.dart';
import 'package:movie_app/features/movies_info/domain/usecases/remove_favourite_movies_usecase.dart';
import 'package:movie_app/features/movies_info/domain/usecases/search_movies_usecase.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/favourite_movies_bloc/favourite_movies_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/genres_bloc/genres_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/movies_bloc/movies_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/search_movies_bloc/search_movies_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  //register http.client
  getIt.registerSingleton<http.Client>(http.Client());

  //register MovieAPIService
  getIt.registerSingleton<MovieAPISerVice>(MovieAPISerVice(getIt.get<http.Client>()));

  //register repository
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(getIt.get<MovieAPISerVice>()),
  );

  getIt.registerLazySingleton<FirebaseAuthRepository>(
    () => FirebaseAuthRepository(),
  );

  //register usecase
  getIt.registerLazySingleton<GetMoviesUseCase>(
    () => GetMoviesUseCase(getIt.get<MovieRepository>()),
  );

  getIt.registerLazySingleton<GetGenresUseCase>(
    () => GetGenresUseCase(getIt.get<MovieRepository>()),
  );

  getIt.registerLazySingleton<GetMovieDetailsUseCase>(
    () => GetMovieDetailsUseCase(getIt()),
  );

  getIt.registerFactory<GetSimilarMoviesUseCase>(
    () => GetSimilarMoviesUseCase(getIt()),
  );

  getIt.registerLazySingleton<GetRecommendMoviesUseCase>(
    () => GetRecommendMoviesUseCase(getIt()),
  );

  getIt.registerLazySingleton<GetReviewsMovieUseCase>(
    () => GetReviewsMovieUseCase(getIt()),
  );

  getIt.registerLazySingleton<GetCastsMovieUseCase>(
    () => GetCastsMovieUseCase(getIt()),
  );

  getIt.registerLazySingleton<SearchMoviesUseCase>(
    () => SearchMoviesUseCase(getIt()),
  );

  getIt.registerLazySingleton<GetFavouriteMoviesUsecase>(
    () => GetFavouriteMoviesUsecase(getIt()),
  );

  getIt.registerLazySingleton<AddFavouriteMoviesUsecase>(
    () => AddFavouriteMoviesUsecase(getIt()),
  );

  getIt.registerLazySingleton<RemoveFavouriteMovieUsecase>(
    () => RemoveFavouriteMovieUsecase(getIt()),
  );

  getIt.registerLazySingleton<RegisterUsecase>(
    () => RegisterUsecase(getIt()),
  );

  getIt.registerLazySingleton<GetImagesMovieUsecase>(
    () => GetImagesMovieUsecase(getIt()),
  );

  //register bloc
  getIt.registerLazySingleton<MoviesBloc>(
    () => MoviesBloc(getIt.get<GetMoviesUseCase>()),
  );

  getIt.registerLazySingleton<GenresBloc>(
    () => GenresBloc(getIt.get<GetGenresUseCase>()),
  );

  getIt.registerLazySingleton<SearchMoviesBloc>(
    () => SearchMoviesBloc(getIt()),
  );

  getIt.registerLazySingleton<FavouriteMoviesBloc>(
    () => FavouriteMoviesBloc(),
  );

  getIt.registerSingleton<AuthBloc>(
    AuthBloc(),
  );

  //register user
  getIt.registerLazySingleton<User>(() {
    return FirebaseAuth.instance.currentUser!;
  });
}
