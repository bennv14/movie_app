import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/data/models/movie_request.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_similar_movies_usecase.dart';

part 'recomment_movies_state.dart';
part 'recomment_movies_event.dart';

class RecommentMoviesBloc extends Bloc<RecommentMoviesEvent, RecommenetMoviesState> {
  final GetSimilarMoviesUseCase _getSimilarMoviesUseCase;

  RecommentMoviesBloc(this._getSimilarMoviesUseCase)
      : super(const RecommenetMoviesState()) {
    on<InitSimilarMovies>(_onInit);
    on<FetchSimilarMovies>(_onFetching);
  }

  FutureOr<void> _onInit(
      InitSimilarMovies event, Emitter<RecommenetMoviesState> emit) async {
    emit(state.copyWith(id: event.id, status: RecommentMoviesStatus.loading));
    try {
      final dataState = await _getSimilarMoviesUseCase(
          params: MovieRequest(id: state.id, page: state.currentPage + 1));
      if (dataState is DataSuccess) {
        final dataDecode = json.decode(dataState.data!.response.body);

        emit(
          state.copyWith(
            status: RecommentMoviesStatus.success,
            movies: dataState.data!.responseData!,
            currentPage: dataDecode['page'],
            hasReachedMax: dataDecode['page'] >= dataDecode['total_pages'],
          ),
        );
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'RecommentMoviesBloc');
    }
  }

  FutureOr<void> _onFetching(
      FetchSimilarMovies event, Emitter<RecommenetMoviesState> emit) async {
    emit(state.copyWith(status: RecommentMoviesStatus.loading));
    try {
      final dataState = await _getSimilarMoviesUseCase(
          params: MovieRequest(id: state.id, page: state.currentPage + 1));
      if (dataState is DataSuccess) {
        final dataDecode = json.decode(dataState.data!.response.body);

        emit(
          state.copyWith(
            status: RecommentMoviesStatus.success,
            movies: List.of(state.movies)..addAll(dataState.data!.responseData!),
            currentPage: dataDecode['page'],
            hasReachedMax: dataDecode['page'] >= dataDecode['total_pages'],
          ),
        );
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'RecommentMoviesBloc');
    }
  }
}
