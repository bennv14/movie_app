part of 'genres_bloc.dart';

abstract class GenresEvent extends Equatable {}

class GetGenresEvent extends GenresEvent {
  final String language;

  GetGenresEvent({this.language = 'vi'});

  @override
  List<Object?> get props => [language];
}

class AddGenresSelectedEvent extends GenresEvent {
  final int genreSelectedID;

  AddGenresSelectedEvent({required this.genreSelectedID});

  @override
  List<Object?> get props => [genreSelectedID];
}

class RemoveGenresSelectedEvent extends GenresEvent {
  final int genreSelectedID;

  RemoveGenresSelectedEvent({required this.genreSelectedID});

  @override
  List<Object?> get props => [genreSelectedID];
}
