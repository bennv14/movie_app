part of 'recommendations_bloc.dart';

enum RecommendationsStatus { initial, waiting, success, failure }

class RecommendationsState extends Equatable {
  final RecommendationsStatus status;
  final List<MovieEntity> recommendations;
  final bool hasReachMax;

  const RecommendationsState({
    this.status = RecommendationsStatus.initial,
    this.recommendations = const [],
    this.hasReachMax = false,
  });

  RecommendationsState copyWith({
    RecommendationsStatus? status,
    List<MovieEntity>? recommendations,
    bool? hasReachMax,
  }) {
    return RecommendationsState(
      status: status ?? this.status,
      recommendations: recommendations ?? this.recommendations,
      hasReachMax: hasReachMax ?? this.hasReachMax,
    );
  }

  @override
  List<Object> get props => [status, recommendations, hasReachMax];
}
