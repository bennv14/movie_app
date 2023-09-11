import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/models/movie.dart';

part 'similar_event.dart';
part 'similar_state.dart';

class SimilarBloc extends Bloc<SimilarEvent, SimilarState> {
  final Function funcFetch;
  SimilarBloc(this.funcFetch) : super(const SimilarState()) {
    on<InitialSimilarEvent>(_onInitial);
    on<FetchDataSimilarEvent>(_onFetchData);
  }

  FutureOr<void> _onInitial(InitialSimilarEvent event, Emitter<SimilarState> emit) async {
    emit(state.copyWith(status: SimilarStatus.initial));
    try {
      final data = await funcFetch();
      emit(state.copyWith(
        status: SimilarStatus.success,
        similars: [...state.similars, ...data[0]],
        hasReachMax: data[1],
      ));
      if (state.hasReachMax) {
        emit(state.copyWith(hasReachMax: true));
      }
    } catch (e) {
      log(name: "ReviewsBloc", "Failure: ${e.toString()}");
      emit(state.copyWith(
        status: SimilarStatus.failure,
      ));
    }
  }

  FutureOr<void> _onFetchData(
      FetchDataSimilarEvent event, Emitter<SimilarState> emit) async {
    emit(state.copyWith(status: SimilarStatus.waiting));
    try {
      final data = await funcFetch();
      emit(state.copyWith(
        status: SimilarStatus.success,
        similars: [...state.similars, ...data[0]],
        hasReachMax: data[1],
      ));
      if (state.hasReachMax) {
        emit(state.copyWith(hasReachMax: true));
      }
    } catch (e) {
      log(name: "ReviewsBloc", "Failure: ${e.toString()}");
      emit(state.copyWith(
        status: SimilarStatus.failure,
      ));
    }
  }
}
