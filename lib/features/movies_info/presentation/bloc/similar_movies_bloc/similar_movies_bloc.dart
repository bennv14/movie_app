import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/data/models/movie_request.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_similar_movies_usecase.dart';

part 'similar_movies_state.dart';
part 'similar_movies_event.dart';

class SimilarMoviesBloc extends Bloc<SimilarMoviesEvent, SimilarMoviesState> {
  final GetSimilarMoviesUseCase _getSimilarMoviesUseCase;

  SimilarMoviesBloc(this._getSimilarMoviesUseCase) : super(const SimilarMoviesState()) {
    on<InitSimilarMovies>(_onInit);
    on<FetchSimilarMovies>(_onFetching);
  }

  FutureOr<void> _onInit(
      InitSimilarMovies event, Emitter<SimilarMoviesState> emit) async {
    emit(state.copyWith(id: event.id, status: SimilarMoviesStatus.loading));
    try {
      final dataState = await _getSimilarMoviesUseCase(
          params: MovieRequest(id: state.id, page: state.currentPage + 1));
      if (dataState is DataSuccess) {
        final dataDecode = json.decode(dataState.data!.response.body);

        emit(
          state.copyWith(
            status: SimilarMoviesStatus.success,
            movies: dataState.data!.responseData!,
            currentPage: dataDecode['page'],
            hasReachedMax: dataDecode['page'] >= dataDecode['total_pages'],
          ),
        );
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'SimilarMoviesBloc');
    }
  }

  FutureOr<void> _onFetching(
      FetchSimilarMovies event, Emitter<SimilarMoviesState> emit) async {
    emit(state.copyWith(status: SimilarMoviesStatus.loading));
    try {
      final dataState = await _getSimilarMoviesUseCase(
          params: MovieRequest(id: state.id, page: state.currentPage + 1));
      if (dataState is DataSuccess) {
        final dataDecode = json.decode(dataState.data!.response.body);

        emit(
          state.copyWith(
            status: SimilarMoviesStatus.success,
            movies: List.of(state.movies)..addAll(dataState.data!.responseData!),
            currentPage: dataDecode['page'],
            hasReachedMax: dataDecode['page'] >= dataDecode['total_pages'],
          ),
        );
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'SimilarMoviesBloc');
    }
  }
}
