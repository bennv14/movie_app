part of 'recomment_movies_bloc.dart';

abstract class RecommentMoviesEvent extends Equatable {}

class InitSimilarMovies extends RecommentMoviesEvent {
  final int id;

  InitSimilarMovies(this.id);
  @override
  List<Object?> get props => [];
}

class FetchSimilarMovies extends RecommentMoviesEvent {
  @override
  List<Object?> get props => [];
}
