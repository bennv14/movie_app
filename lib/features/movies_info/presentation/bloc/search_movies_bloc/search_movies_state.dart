part of 'search_movies_bloc.dart';

enum SearchMoviesStatus { init, loading, success, error }

class SearchMoviesState extends Equatable {
  final String query;
  final SearchMoviesStatus status;
  final List<MovieEntity> movies;
  final int currentPage;
  final bool hasReachedMax;

  const SearchMoviesState({
    this.query = '',
    this.status = SearchMoviesStatus.init,
    this.movies = const [],
    this.currentPage = 0,
    this.hasReachedMax = false,
  });

  SearchMoviesState copyWith({
    String? query,
    SearchMoviesStatus? status,
    List<MovieEntity>? movies,
    int? currentPage,
    bool? hasReachedMax,
}){
    return SearchMoviesState(
      query: query??this.query,
      status: status??this.status,
      movies: movies??this.movies,
      currentPage: currentPage??this.currentPage,
      hasReachedMax: hasReachedMax??this.hasReachedMax,
    );
}

  @override
  List<Object?> get props =>
      [query, status, movies, currentPage, hasReachedMax];
}
