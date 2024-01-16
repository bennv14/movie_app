part of 'recommend_movies_bloc.dart';

abstract class RecommendMoviesEvent extends Equatable {}

class InitRecommendMovies extends RecommendMoviesEvent {
  final int id;

  InitRecommendMovies(this.id);
  @override
  List<Object?> get props => [];
}

class FetchRecommendMovies extends RecommendMoviesEvent {
  @override
  List<Object?> get props => [];
}
