part of 'genres_bloc.dart';

enum GenresStatus {
  loading,
  success,
  failure,
}

class GenresState extends Equatable {
  final GenresStatus status;
  final List<GenreModel> genres;
  final List<int> genresSelected;
  final String language;

  const GenresState({
    this.status = GenresStatus.loading,
    this.genres = const [],
    this.genresSelected = const [],
    this.language = 'vi',
  });

  GenresState copyWith({
    GenresStatus? status,
    List<GenreModel>? genres,
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
