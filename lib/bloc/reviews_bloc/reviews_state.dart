part of 'reviews_bloc.dart';

enum ReviewStatus { initial, success, failure, waiting, hasReachMax }

class ReviewsState extends Equatable {
  final ReviewStatus status;
  final int totalReviews;
  final List<Review> reviews;
  final bool hasReachMax;

  const ReviewsState({
    this.status = ReviewStatus.initial,
    this.totalReviews = 0,
    this.reviews = const [],
    this.hasReachMax = false,
  });

  ReviewsState copyWith({
    ReviewStatus? status,
    int? totalReviews,
    List<Review>? reviews,
    bool? hasReachMax,
  }) {
    return ReviewsState(
      status: status ?? this.status,
      totalReviews: totalReviews ?? this.totalReviews,
      reviews: reviews ?? this.reviews,
      hasReachMax: hasReachMax ?? this.hasReachMax,
    );
  }

  @override
  List<Object> get props => [status, totalReviews, reviews, hasReachMax];
}
