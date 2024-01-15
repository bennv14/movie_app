part of 'similar_movies_bloc.dart';

enum SimilarMoviesStatus { init, loading, success, errorr }

class SimilarMoviesState extends Equatable {
  final int id;
  final SimilarMoviesStatus status;
  final List<MovieEntity> movies;
  final bool hasReachedMax;
  final int currentPage;

  const SimilarMoviesState({
    this.id = 0,
    this.status = SimilarMoviesStatus.init,
    this.movies = const [],
    this.hasReachedMax = false,
    this.currentPage = 0,
  });

  SimilarMoviesState copyWith({
    int? id,
    SimilarMoviesStatus? status,
    List<MovieEntity>? movies,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return SimilarMoviesState(
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
