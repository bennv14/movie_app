import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  Function funcFetch;
  MoviesBloc(this.funcFetch) : super(const MoviesState()) {
    on<InitMovies>(_onInitial);
    on<FetchMovies>(_onFetchMovies);
    on<ChangeFuncFetchMovies>(_onChangeFunc);
  }

  FutureOr<void> _onFetchMovies(
    FetchMovies event,
    Emitter<MoviesState> emit,
  ) async {
    if (state.hasReachedMax) {
      return;
    } else {
      emit(state.copyWith(status: MoviesStatus.waiting));
      try {
        List<MovieEntity> data = await funcFetch();
        emit(state.copyWith(
          status: MoviesStatus.success,
          movies: List.of(state.movies)..addAll(data),
        ));
      } on Exception catch (e) {
        emit(state.copyWith(status: MoviesStatus.failure));
        log(name: "_onFetchMovies", e.toString());
      }
    }
  }

  FutureOr<void> _onChangeFunc(
    ChangeFuncFetchMovies event,
    Emitter<MoviesState> emit,
  ) async {
    funcFetch = event.funFetch;
    emit(const MoviesState());
    try {
      List<MovieEntity> data = await funcFetch();
      emit(state.copyWith(
        status: MoviesStatus.success,
        movies: List.of(state.movies)..addAll(data),
      ));
    } on Exception catch (e) {
      emit(state.copyWith(status: MoviesStatus.failure));
      log(name: "_onFetchMovies", e.toString());
    }
  }

  FutureOr<void> _onInitial(
    InitMovies event,
    Emitter<MoviesState> emit,
  ) async {
    emit(const MoviesState());
    try {
      List<MovieEntity> data = await funcFetch();
      emit(state.copyWith(
        status: MoviesStatus.success,
        movies: List.of(state.movies)..addAll(data),
      ));
    } on Exception catch (e) {
      emit(state.copyWith(status: MoviesStatus.failure));
      log(name: "_onInittial", e.toString());
    }
  }
}
