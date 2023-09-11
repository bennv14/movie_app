part of 'similar_bloc.dart';

enum SimilarStatus { initial, waiting, success, failure }

class SimilarState extends Equatable {
  final SimilarStatus status;
  final List<Movie> similars;
  final bool hasReachMax;

  const SimilarState({
    this.status = SimilarStatus.initial,
    this.similars = const [],
    this.hasReachMax = false,
  });

  SimilarState copyWith({
    SimilarStatus? status,
    List<Movie>? similars,
    bool? hasReachMax,
  }) {
    return SimilarState(
      status: status ?? this.status,
      similars: similars ?? this.similars,
      hasReachMax: hasReachMax ?? this.hasReachMax,
    );
  }

  @override
  List<Object> get props => [status, similars, hasReachMax];
}
