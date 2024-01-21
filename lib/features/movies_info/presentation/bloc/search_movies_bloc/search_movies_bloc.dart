import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/data/models/search_movies_request.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_info/domain/usecases/search_movies_usecase.dart';
import 'package:rxdart/rxdart.dart';

part 'search_movies_event.dart';

part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMoviesUseCase _searchMoviesUsecase;

  SearchMoviesBloc(this._searchMoviesUsecase) : super(const SearchMoviesState()) {
    on<SearchMovies>(
      _onSearch,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 100))
          .distinct()
          .switchMap(mapper),
    );
  }

  FutureOr<void> _onSearch(
    SearchMovies event,
    Emitter<SearchMoviesState> emit,
  ) async {
    emit(
      state.copyWith(query: event.query, status: SearchMoviesStatus.loading),
    );
    final dataState = await _searchMoviesUsecase(
        params: SearchMoviesRequest(
      query: state.query,
      page: state.currentPage + 1,
    ));
    if (dataState is DataSuccess) {
      emit(state.copyWith(
        status: SearchMoviesStatus.success,
        movies: dataState.data!.responseData!,
      ));
    }
  }
}
