import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/models/review.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  Function funcFetch;
  ReviewsBloc(this.funcFetch) : super(const ReviewsState()) {
    on<Initial>(_onInitial);
    on<FetchData>(_onFetchData);
  }

  FutureOr<void> _onInitial(Initial event, Emitter<ReviewsState> emit) async {
    emit(state.copyWith(status: ReviewStatus.initial));
    try {
      final data = await funcFetch();
      emit(state.copyWith(
        status: ReviewStatus.success,
        reviews: [...state.reviews, ...data[1]],
        totalReviews: data[0],
        hasReachMax: data[2],
      ));
      if (state.hasReachMax) {
        emit(state.copyWith(status: ReviewStatus.hasReachMax));
        return;
      }
    } catch (e) {
      log(name: "ReviewsBloc", "Failure: ${e.toString()}");
      emit(state.copyWith(
        status: ReviewStatus.failure,
      ));
    }
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<ReviewsState> emit) async {
    if (state.hasReachMax) {
      emit(state.copyWith(status: ReviewStatus.hasReachMax));
      return;
    }

    emit(state.copyWith(status: ReviewStatus.waiting));
    try {
      final data = await funcFetch();

      emit(state.copyWith(
        status: ReviewStatus.success,
        reviews: [...state.reviews, ...data[1]],
        totalReviews: data[0],
        hasReachMax: data[2],
      ));
    } catch (e) {
      log(name: "ReviewsBloc", "Failure: ${e.toString()}");
      emit(state.copyWith(
        status: ReviewStatus.failure,
      ));
    }
  }
}
