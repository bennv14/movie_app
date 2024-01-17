part of 'reviews_movie_bloc.dart';

enum ReviewsMovieStatus { init, loading, success, error }

class ReviewsMovieState extends Equatable {
  final int id;
  final ReviewsMovieStatus status;
  final List<ReviewEntity> reviews;
  final bool hasReachedMax;
  final int currentPage;
  final int totalReviews;

  const ReviewsMovieState({
    this.id = 0,
    this.status = ReviewsMovieStatus.init,
    this.reviews = const [],
    this.hasReachedMax = false,
    this.currentPage = 0,
    this.totalReviews = 0,
  });

  ReviewsMovieState copyWith({
    int? id,
    ReviewsMovieStatus? status,
    List<ReviewEntity>? reviews,
    bool? hasReachedMax,
    int? currentPage,
    int? totalReviews
  }) {
    return ReviewsMovieState(
      id: id ?? this.id,
      status: status ?? this.status,
      reviews: reviews ?? this.reviews,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      totalReviews: totalReviews??this.totalReviews,
    );
  }

  @override
  List<Object?> get props => [id, status, reviews, hasReachedMax, currentPage];
}
