part of 'search_movies_bloc.dart';

abstract class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();
}

class SearchMovies extends SearchMoviesEvent {
  final String _query;
  const SearchMovies(this._query);
  String get query => Uri.encodeFull(_query);
  @override
  List<Object?> get props => [_query];
}

class FetchSearchMovies extends SearchMoviesEvent {
  @override
  List<Object?> get props => [];
}
