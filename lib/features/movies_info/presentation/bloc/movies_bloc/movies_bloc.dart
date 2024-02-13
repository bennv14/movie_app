import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/data/dto/movies_request.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_movies_usecase.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetMoviesUseCase _getMoviesUseCase;
  MoviesBloc(this._getMoviesUseCase) : super(const MoviesState()) {
    on<InitMovies>(_onInitial);
    on<FetchMovies>(_onFetchMovies);
    on<ChangeURI>(_onChangeURI);
  }

  FutureOr<void> _onInitial(
    InitMovies event,
    Emitter<MoviesState> emit,
  ) async {
    if (state.hasReachedMax) {
      return null;
    }
    try {
      final dataState = await _getMoviesUseCase(
        params: MoviesRequest(
          curentPage: state.currentPage + 1,
          uri: state.uri,
        ),
      );

      if (dataState is DataSuccess) {
        final dataDecode = json.decode(dataState.data!.response.body);

        emit(state.copyWith(
          status: MoviesStatus.success,
          movies: dataState.data!.responseData!,
          currentPage: dataDecode['page'],
          hasReachedMax: dataDecode['page'] >= dataDecode['total_pages'],
        ));
      } else {
        emit(state.copyWith(
          status: MoviesStatus.failure,
        ));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: MoviesStatus.failure));
      log(name: "_onInittial", e.toString());
    }
  }

  FutureOr<void> _onFetchMovies(
    FetchMovies event,
    Emitter<MoviesState> emit,
  ) async {
    if (state.hasReachedMax) {
      return null;
    }
    if (state.hasReachedMax) {
      return;
    } else {
      emit(state.copyWith(status: MoviesStatus.waiting));
      try {
        final dataState = await _getMoviesUseCase(
          params: MoviesRequest(
            curentPage: state.currentPage + 1,
            uri: state.uri,
          ),
        );

        if (dataState is DataSuccess) {
          final dataDecode = json.decode(dataState.data!.response.body);
          emit(
            state.copyWith(
              status: MoviesStatus.success,
              movies: List.of(state.movies)
                ..addAll(List.of(dataState.data!.responseData!)),
              currentPage: dataDecode['page'],
              hasReachedMax: dataDecode['page'] >= dataDecode['total_pages'],
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: MoviesStatus.failure,
            ),
          );
        }
      } on Exception catch (e) {
        emit(state.copyWith(status: MoviesStatus.failure));
        log(name: "_onFetchMovies", e.toString());
      }
    }
  }

  FutureOr<void> _onChangeURI(
    ChangeURI event,
    Emitter<MoviesState> emit,
  ) async {
    emit(const MoviesState().copyWith(uri: event.uri));
    add(InitMovies());
  }
}
