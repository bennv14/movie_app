part of 'reviews_bloc.dart';

enum ReviewStatus { initial, success, failure, waiting }

class ReviewsState extends Equatable {
  final ReviewStatus status;
  final int totalReviews;
  final int curentPage;
  final int totalPages;
  final List<Review> reviews;

  const ReviewsState({
    this.status = ReviewStatus.initial,
    this.totalReviews = 0,
    this.curentPage = 1,
    this.totalPages = 1,
    this.reviews = const [],
  });

  ReviewsState copyWith({
    ReviewStatus? status,
    int? totalReviews,
    int? curentPage,
    int? totalPages,
    List<Review>? reviews,
  }) {
    return ReviewsState(
      status: status ?? this.status,
      totalReviews: totalReviews ?? this.totalReviews,
      curentPage: curentPage ?? this.curentPage,
      totalPages: totalPages ?? this.totalPages,
      reviews: reviews ?? this.reviews,
    );
  }

  @override
  List<Object> get props => [status, totalReviews, reviews];
}
