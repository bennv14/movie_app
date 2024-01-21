part of 'similar_movies_bloc.dart';

abstract class SimilarMoviesEvent extends Equatable {
  const SimilarMoviesEvent();
}

class InitSimilarMovies extends SimilarMoviesEvent {
  final int id;

  const InitSimilarMovies(this.id);
  @override
  List<Object?> get props => [id];
}

class FetchSimilarMovies extends SimilarMoviesEvent {
  @override
  List<Object?> get props => [];
}
