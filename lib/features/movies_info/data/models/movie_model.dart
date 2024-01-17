import 'package:movie_app/features/movies_info/data/models/company_model.dart';
import 'package:movie_app/features/movies_info/data/models/genre_model.dart';
import 'package:movie_app/features/movies_info/domain/entities/company_entity.dart';
import 'package:movie_app/features/movies_info/domain/entities/genre_entity.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    bool? adult,
    String? backdropPath,
    int? budget,
    List<GenreEntity>? genres,
    List? genreIds,
    String? homepage,
    int? id,
    String? imdbId,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    List<CompanyEntity>? productionCompanies,
    String? releaseDate,
    int? revenue,
    int? runtime,
    String? status,
    String? tagline,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) : super(
          adult: adult,
          backdropPath: backdropPath,
          budget: budget,
          genres: genres,
          genreIds: genreIds,
          homepage: homepage,
          id: id,
          imdbId: imdbId,
          originalLanguage: originalLanguage,
          originalTitle: originalTitle,
          overview: overview,
          popularity: popularity,
          posterPath: posterPath,
          productionCompanies: productionCompanies ,
          releaseDate: releaseDate,
          revenue: revenue,
          runtime: runtime,
          status: status,
          tagline: tagline,
          title: title,
          video: video,
          voteAverage: voteAverage,
          voteCount: voteCount,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    var genres = <GenreEntity>[];
    if (json['genres'] != null) {
      json['genres'].forEach((v) {
        genres.add(GenreModel.fromJson(v));
      });
    }

    var productionCompanies = <CompanyEntity>[];
    if (json['production_companies'] != null) {
      json['production_companies'].forEach((v) {
        productionCompanies.add(CompanyModel.fromJson(v));
      });
    }
    return MovieModel(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      budget: json['budget'],
      genres: genres,
      homepage: json['homepage'],
      id: json['id'],
      imdbId: json['imdb_id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble(),
      posterPath: json['poster_path'],
      productionCompanies: productionCompanies,
      releaseDate: json['release_date'],
      revenue: json['revenue'],
      runtime: json['runtime'],
      status: json['status'],
      tagline: json['tagline'],
      title: json['title'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['budget'] = budget;
    if (genres != null) {
      data['genres'] = genres!.map((v) => (v as GenreModel).toJson()).toList();
    }
    data['homepage'] = homepage;
    data['id'] = id;
    data['imdb_id'] = imdbId;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    if (productionCompanies != null) {
      data['production_companies'] = productionCompanies!.map((v) => (v as CompanyModel).toJson()).toList();
    }
    data['release_date'] = releaseDate;
    data['revenue'] = revenue;
    data['runtime'] = runtime;
    data['status'] = status;
    data['tagline'] = tagline;
    data['title'] = title;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }

  @override
  String toString() {
    return "{$id $title}";
  }
}
