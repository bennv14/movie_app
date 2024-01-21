import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/data/models/movie_request.dart';
import 'package:movie_app/features/movies_info/domain/entities/review_entity.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_reviews_movie_usecase.dart';

part 'reviews_movie_state.dart';
part 'reviews_movie_event.dart';

class ReviewsMovieBloc extends Bloc<ReviewsMovieEvent, ReviewsMovieState> {
  final GetReviewsMovieUseCase _getReviewsMovieUseCase;

  ReviewsMovieBloc(this._getReviewsMovieUseCase) : super(const ReviewsMovieState()) {
    on<InitReviewsMovie>(_onInit);
    on<FetchReviewsMovie>(_onFetching);
  }

  FutureOr<void> _onInit(InitReviewsMovie event, Emitter<ReviewsMovieState> emit) async {
    if (state.hasReachedMax) {
      return null;
    }
    emit(state.copyWith(id: event.id, status: ReviewsMovieStatus.loading));
    try {
      final dataState = await _getReviewsMovieUseCase(
        params: MovieRequest(id: state.id, page: state.currentPage + 1),
      );
      if (dataState is DataSuccess) {
        final dataDecode = json.decode(dataState.data!.response.body);
        emit(
          state.copyWith(
            status: ReviewsMovieStatus.success,
            reviews: List.of(dataState.data!.responseData!),
            currentPage: dataDecode['page'],
            hasReachedMax: dataDecode['page'] >= dataDecode['total_pages'],
            totalReviews: dataDecode['total_results'],
          ),
        );
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'ReviewsMovieBloc');
    }
  }

  FutureOr<void> _onFetching(
      FetchReviewsMovie event, Emitter<ReviewsMovieState> emit) async {
    if (state.hasReachedMax) {
      return null;
    } else {
      try {
        final dataState = await _getReviewsMovieUseCase(
          params: MovieRequest(id: state.id, page: state.currentPage + 1),
        );
        if (dataState is DataSuccess) {
          final dataDecode = json.decode(dataState.data!.response.body);
          emit(
            state.copyWith(
              status: ReviewsMovieStatus.success,
              reviews: List.of(state.reviews)..addAll(dataState.data!.responseData!),
              currentPage: dataDecode['page'],
              hasReachedMax: dataDecode['page'] >= dataDecode['total_pages'],
              totalReviews: dataDecode['total_results'],
            ),
          );
        } else {
          log(name: "ReviewsMovieStatus", dataState.exception.toString());
        }
      } on Exception catch (e) {
        emit(state.copyWith(status: ReviewsMovieStatus.error));
        log(name: "ReviewsMovieStatus", e.toString());
      }
    }
  }
}
