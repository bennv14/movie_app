part of 'recomment_movies_bloc.dart';

enum RecommentMoviesStatus { init, loading, success, errorr }

class RecommenetMoviesState extends Equatable {
  final int id;
  final RecommentMoviesStatus status;
  final List<MovieEntity> movies;
  final bool hasReachedMax;
  final int currentPage;

  const RecommenetMoviesState({
    this.id = 0,
    this.status = RecommentMoviesStatus.init,
    this.movies = const [],
    this.hasReachedMax = false,
    this.currentPage = 0,
  });

  RecommenetMoviesState copyWith({
    int? id,
    RecommentMoviesStatus? status,
    List<MovieEntity>? movies,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return RecommenetMoviesState(
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
