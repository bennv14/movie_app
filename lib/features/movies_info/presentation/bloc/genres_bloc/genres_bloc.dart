import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/data/models/genre_model.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_genres_usecase.dart';

part 'genres_event.dart';
part 'genres_state.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  final GetGenresUseCase _getGenresUseCase;
  GenresBloc(this._getGenresUseCase) : super(const GenresState()) {
    on<GetGenresEvent>(_onGetGenresEvent);
    on<AddGenresSelectedEvent>(_onAddGenresSelectedEvent);
    on<RemoveGenresSelectedEvent>(_onRemoveGenresSelectedEvent);
  }

  FutureOr<void> _onGetGenresEvent(
    GetGenresEvent event,
    Emitter<GenresState> emit,
  ) async {
    emit(state.copyWith(
      status: GenresStatus.loading,
      language: event.language,
    ));

    try {
      final dataState = await _getGenresUseCase(params: state.language);
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            status: GenresStatus.success, genres: dataState.data!.responseData!));
      }
    } on Exception catch (e) {
      log(name: 'Genres Bloc', e.toString());
      emit(state.copyWith(status: GenresStatus.failure));
    }
  }

  FutureOr<void> _onAddGenresSelectedEvent(
    AddGenresSelectedEvent event,
    Emitter<GenresState> emit,
  ) {
    emit(
      state.copyWith(
        genresSelected: List.of(state.genresSelected)..add(event.genreSelectedID),
      ),
    );
    log(name: "Add genres selected", state.genresSelected.toString());
  }

  FutureOr<void> _onRemoveGenresSelectedEvent(
    RemoveGenresSelectedEvent event,
    Emitter<GenresState> emit,
  ) {
    emit(
      state.copyWith(
        genresSelected: List.of(state.genresSelected)..remove(event.genreSelectedID),
      ),
    );
    log(name: "Remove genres selected", state.genresSelected.toString());
  }
}
