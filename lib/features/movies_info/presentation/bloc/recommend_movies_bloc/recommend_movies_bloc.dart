import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/data/models/movie_request.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_recommend_movies_usecase.dart';

part 'recommend_movies_state.dart';
part 'recommend_movies_event.dart';

class RecommendMoviesBloc extends Bloc<RecommendMoviesEvent, RecommendMoviesState> {
  final GetRecommendMoviesUseCase _getRecommendMoviesUseCase;

  RecommendMoviesBloc(this._getRecommendMoviesUseCase)
      : super(const RecommendMoviesState()) {
    log('init');
    on<InitRecommendMovies>(_onInit);
    on<FetchRecommendMovies>(_onFetching);
  }

  FutureOr<void> _onInit(
      InitRecommendMovies event, Emitter<RecommendMoviesState> emit) async {
    if (state.hasReachedMax) {
      return null;
    }
    emit(state.copyWith(id: event.id, status: RecommendMoviesStatus.loading));
    try {
      final dataState = await _getRecommendMoviesUseCase(
          params: MovieRequest(id: state.id, page: state.currentPage + 1));
      if (dataState is DataSuccess) {
        final dataDecode = json.decode(dataState.data!.response.body);
        emit(
          state.copyWith(
            status: RecommendMoviesStatus.success,
            movies: dataState.data!.responseData!,
            currentPage: dataDecode['page'],
            hasReachedMax: dataDecode['page'] >= dataDecode['total_pages'],
          ),
        );
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'RecommendMoviesBloc');
    }
  }

  FutureOr<void> _onFetching(
      FetchRecommendMovies event, Emitter<RecommendMoviesState> emit) async {
    if (state.hasReachedMax) {
      return null;
    }

    emit(state.copyWith(status: RecommendMoviesStatus.loading));
    try {
      final dataState = await _getRecommendMoviesUseCase(
        params: MovieRequest(id: state.id, page: state.currentPage + 1),
      );
      if (dataState is DataSuccess) {
        final dataDecode = json.decode(dataState.data!.response.body);

        emit(
          state.copyWith(
            status: RecommendMoviesStatus.success,
            movies: List.of(state.movies)..addAll(dataState.data!.responseData!),
            currentPage: dataDecode['page'],
            hasReachedMax: dataDecode['page'] >= dataDecode['total_pages'],
          ),
        );
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'RecommendMoviesBloc');
    }
  }
}
