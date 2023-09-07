part of 'genres_bloc.dart';

abstract class GenresEvent extends Equatable {}

class InitGenresEvent extends GenresEvent {
  final String language;

  InitGenresEvent({this.language = 'vi'});

  @override
  List<Object?> get props => [language];
}

class LoadingGenresEvent extends GenresEvent {
  @override
  List<Object?> get props => [];
}

class AddGenresSelectedEvent extends GenresEvent {
  final int genresSelectedID;

  AddGenresSelectedEvent({required this.genresSelectedID});

  @override
  List<Object?> get props => [genresSelectedID];
}

class RemoveGenresSelectedEvent extends GenresEvent {
  final int genresSelectedID;

  RemoveGenresSelectedEvent({required this.genresSelectedID});

  @override
  List<Object?> get props => [genresSelectedID];
}
