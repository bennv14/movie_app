part of 'similar_movies_bloc.dart';

abstract class SimilarMoviesEvent extends Equatable {}

class InitSimilarMovies extends SimilarMoviesEvent {
  final int id;

  InitSimilarMovies(this.id);
  @override
  List<Object?> get props => [];
}

class FetchSimilarMovies extends SimilarMoviesEvent {
  @override
  List<Object?> get props => [];
}
