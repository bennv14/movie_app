import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/api/genres_api.dart';
import 'package:movie_app/models/genre.dart';

part 'genres_event.dart';
part 'genres_state.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  GenresBloc() : super(const GenresState()) {
    on<InitGenresEvent>(_onInitGenresEvent);
    on<LoadingGenresEvent>(_loandingGenresEvent);
    on<AddGenresSelectedEvent>(_onAddGenresSelectedEvent);
    on<RemoveGenresSelectedEvent>(_onRemoveGenresSelectedEvent);
  }

  FutureOr<void> _onInitGenresEvent(
    InitGenresEvent event,
    Emitter<GenresState> emit,
  ) async {
    emit(state.copyWith(
      status: GenresStatus.waiting,
      language: event.language,
    ));

    try {
      List<Genre> genres = await GenresAPI.getAllGenres(language: state.language);
      emit(
        state.copyWith(status: GenresStatus.success, genres: genres),
      );
    } on Exception catch (e) {
      log(name: 'Genres Bloc', e.toString());
      emit(state.copyWith(status: GenresStatus.failure));
    }
  }

  FutureOr<void> _loandingGenresEvent(
    LoadingGenresEvent event,
    Emitter<GenresState> emit,
  ) async {
    emit(state.copyWith(
      status: GenresStatus.waiting,
    ));

    try {
      List<Genre> genres = await GenresAPI.getAllGenres(language: state.language);
      emit(
        state.copyWith(status: GenresStatus.success, genres: genres),
      );
    } on Exception catch (e) {
      log(name: 'Genres Bloc', e.toString());
      emit(state.copyWith(status: GenresStatus.failure));
    }
  }

  FutureOr<void> _onAddGenresSelectedEvent(
    AddGenresSelectedEvent event,
    Emitter<GenresState> emit,
  ) {
    List<int> newGenresSelected = [...state.genresSelected];
    newGenresSelected.add(event.genresSelectedID);
    emit(
      state.copyWith(
        genresSelected: newGenresSelected,
      ),
    );
    log(name: "Add genres selected", state.genresSelected.toString());
  }

  FutureOr<void> _onRemoveGenresSelectedEvent(
    RemoveGenresSelectedEvent event,
    Emitter<GenresState> emit,
  ) {
    List<int> newGenresSelected = [...state.genresSelected];
    newGenresSelected.remove(event.genresSelectedID);
    emit(
      state.copyWith(
        genresSelected: newGenresSelected,
      ),
    );
    log(name: "Remove genres selected", state.genresSelected.toString());
  }
}
