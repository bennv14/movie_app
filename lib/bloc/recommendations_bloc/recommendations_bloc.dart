import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/models/movie.dart';

part 'recommendations_event.dart';
part 'recommendations_state.dart';

class RecommendationsBloc extends Bloc<RecommendationsEvent, RecommendationsState> {
  final Function funcFetch;
  RecommendationsBloc(this.funcFetch) : super(const RecommendationsState()) {
    on<InitialRecommendationsEvent>(_onInitial);
    on<FetchDataRecommendationsEvent>(_onFetchData);
  }

  FutureOr<void> _onInitial(
      InitialRecommendationsEvent event, Emitter<RecommendationsState> emit) async {
    emit(state.copyWith(status: RecommendationsStatus.initial));
    try {
      final data = await funcFetch();
      emit(state.copyWith(
        status: RecommendationsStatus.success,
        recommendations: [...state.recommendations, ...data[0]],
        hasReachMax: data[1],
      ));
      if (state.hasReachMax) {
        emit(state.copyWith(hasReachMax: true));
      }
    } catch (e) {
      log(name: "ReviewsBloc", "Failure: ${e.toString()}");
      emit(state.copyWith(
        status: RecommendationsStatus.failure,
      ));
    }
  }

  FutureOr<void> _onFetchData(
    FetchDataRecommendationsEvent event,
    Emitter<RecommendationsState> emit,
  ) async {
    emit(state.copyWith(status: RecommendationsStatus.waiting));
    try {
      final data = await funcFetch();
      emit(state.copyWith(
        status: RecommendationsStatus.success,
        recommendations: [...state.recommendations, ...data[0]],
        hasReachMax: data[1],
      ));
      if (state.hasReachMax) {
        emit(state.copyWith(hasReachMax: true));
      }
    } catch (e) {
      log(name: "ReviewsBloc", "Failure: ${e.toString()}");
      emit(state.copyWith(
        status: RecommendationsStatus.failure,
      ));
    }
  }
}
