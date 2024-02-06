import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_info/domain/repository/database_repository.dart';

part 'favourite_movies_event.dart';
part 'favourite_movies_state.dart';

class FavouriteMoviesBloc extends Bloc<FavouriteMoviesEvent, FavouriteMoviesState> {
  late DatabaseRepository _databaseRepository;
  FavouriteMoviesBloc() : super(const FavouriteMoviesState()) {
    on<InitialFavouriteMovies>(_onInitial);
    on<AddFavouriteMovies>(_onAdd);
    on<RemoveFavouriteMovies>(_onRemove);
  }

  FutureOr<void> _onInitial(
    InitialFavouriteMovies event,
    Emitter<FavouriteMoviesState> emit,
  ) async {
    _databaseRepository = event._databaseRepository;
    emit(state.copyWith(status: FavouriteMoviesStatus.loading));
    try {
      final dataState = await _databaseRepository.getFavouriteMovies();
      if (dataState is DataSuccess) {
        emit(
          state.copyWith(status: FavouriteMoviesStatus.success, movies: dataState.data!),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: FavouriteMoviesStatus.error));
      log(name: 'FavouriteMoviesBloc', e.toString());
    }
  }

  FutureOr<void> _onAdd(
    AddFavouriteMovies event,
    Emitter<FavouriteMoviesState> emit,
  ) async {
    emit(
      state.copyWith(status: FavouriteMoviesStatus.loading, movies: state.movies),
    );
    try {
      await _databaseRepository.addFavouriteMovie(event.movie);
      emit(
        state.copyWith(
          status: FavouriteMoviesStatus.success,
          movies: state.movies..add(event.movie),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FavouriteMoviesStatus.error,
        ),
      );
      log(name: 'FavouriteMoviesBloc', e.toString());
    }
  }

  FutureOr<void> _onRemove(
    RemoveFavouriteMovies event,
    Emitter<FavouriteMoviesState> emit,
  ) async {
    emit(state.copyWith(status: FavouriteMoviesStatus.loading, movies: state.movies));
    try {
      await _databaseRepository.removeFavouriteMovie(event.movie);
      emit(
        state.copyWith(
            status: FavouriteMoviesStatus.success,
            movies: state.movies..remove(event.movie)),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FavouriteMoviesStatus.error,
        ),
      );
      log(name: 'FavouriteMoviesBloc', e.toString());
    }
  }
}
