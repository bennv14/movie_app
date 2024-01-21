part of 'recommend_movies_bloc.dart';

abstract class RecommendMoviesEvent extends Equatable {
  const RecommendMoviesEvent();
}

class InitRecommendMovies extends RecommendMoviesEvent {
  final int id;

  const InitRecommendMovies(this.id);
  @override
  List<Object?> get props => [id];
}

class FetchRecommendMovies extends RecommendMoviesEvent {
  @override
  List<Object?> get props => [];
}
