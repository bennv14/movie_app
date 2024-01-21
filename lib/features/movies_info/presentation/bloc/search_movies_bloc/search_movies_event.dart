part of 'search_movies_bloc.dart';

abstract class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();
}

class SearchMovies extends SearchMoviesEvent{
 final String query;
  const SearchMovies(this.query);
  @override
  List<Object?> get props => [query];

}
