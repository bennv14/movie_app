import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/data/models/movie_model.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_info/domain/repository/database_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepositoryImpl implements DatabaseRepository {
  final User user;
  FirebaseRepositoryImpl(this.user);
  @override
  Future<void> addFavouriteMovie(MovieEntity movie) async {
    return await FirebaseFirestore.instance
        .collection(userCollections)
        .doc(user.uid.toString())
        .collection(favouriteMovieCollections)
        .doc(movie.id.toString())
        .set((movie as MovieModel).toJson());
  }

  @override
  Future<DataState<List<MovieEntity>>> getFavouriteMovies() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(userCollections)
          .doc(user.uid.toString())
          .collection(favouriteMovieCollections)
          .get();
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
        .collection(userCollections)
        .doc(user.uid.toString())
        .collection(favouriteMovieCollections)
        .doc(movie.id.toString())
        .delete();
  }
}
