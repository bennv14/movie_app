part of 'reviews_movie_bloc.dart';

abstract class ReviewsMovieEvent extends Equatable {}

class InitReviewsMovie extends ReviewsMovieEvent {
  final int id;

  InitReviewsMovie(this.id);
  @override
  List<Object?> get props => [];
}

class FetchReviewsMovie extends ReviewsMovieEvent {
  @override
  List<Object?> get props => [];
}
