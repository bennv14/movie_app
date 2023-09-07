part of 'genres_bloc.dart';

enum GenresStatus {
  waiting,
  success,
  failure,
}

class GenresState extends Equatable {
  final GenresStatus status;
  final List<Genre> genres;
  final List<int> genresSelected;
  final String language;

  const GenresState({
    this.status = GenresStatus.waiting,
    this.genres = const [],
    this.genresSelected = const [],
    this.language = 'vi',
  });

  GenresState copyWith({
    GenresStatus? status,
    List<Genre>? genres,
    List<int>? genresSelected,
    String? language,
  }) {
    return GenresState(
      status: status ?? this.status,
      genres: genres ?? this.genres,
      genresSelected: genresSelected ?? this.genresSelected,
      language: language ?? this.language,
    );
  }

  @override
  List<Object> get props => [status, genres, genresSelected, language];
}
