part of 'recomment_movies_bloc.dart';

abstract class RecommentMoviesEvent extends Equatable {}

class InitRecommentMovies extends RecommentMoviesEvent {
  final int id;

  InitRecommentMovies(this.id);
  @override
  List<Object?> get props => [];
}

class FetchRecommentMovies extends RecommentMoviesEvent {
  @override
  List<Object?> get props => [];
}
