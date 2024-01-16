part of 'recommend_movies_bloc.dart';

enum RecommendMoviesStatus { init, loading, success, error }

class RecommendMoviesState extends Equatable {
  final int id;
  final RecommendMoviesStatus status;
  final List<MovieEntity> movies;
  final bool hasReachedMax;
  final int currentPage;

  const RecommendMoviesState({
    this.id = 0,
    this.status = RecommendMoviesStatus.init,
    this.movies = const [],
    this.hasReachedMax = false,
    this.currentPage = 0,
  });

  RecommendMoviesState copyWith({
    int? id,
    RecommendMoviesStatus? status,
    List<MovieEntity>? movies,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return RecommendMoviesState(
      id: id ?? this.id,
      status: status ?? this.status,
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [id, status, movies, hasReachedMax, currentPage];
}
