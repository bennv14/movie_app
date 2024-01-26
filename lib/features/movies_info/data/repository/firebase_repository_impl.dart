import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/data/models/movie_model.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_info/domain/repository/database_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepositoryImpl implements DatabaseRepository {
  @override
  Future<void> addFavouriteMovie(MovieEntity movie) async {
    return await FirebaseFirestore.instance
        .collection(favouriteMoviesColection)
        .doc(movie.id.toString())
        .set((movie as MovieModel).toJson());
  }

  Future<void> add(int id) async {
    return await FirebaseFirestore.instance
        .collection(favouriteMoviesColection)
        .doc(id.toString())
        .set({'data': 'data'});
  }

  @override
  Future<DataState<List<MovieEntity>>> getFavouriteMovies() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection(favouriteMoviesColection).get();
      final data = snapshot.docs.toList();
      final movies = data.map((e) => MovieModel.fromJson(e.data())).toList();
      return DataSuccess(movies);
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<void> removeFavouriteMovie(MovieEntity movie) async {
    await FirebaseFirestore.instance
        .collection(favouriteMoviesColection)
        .doc(movie.id.toString())
        .delete();
  }
}
