import 'package:equatable/equatable.dart';
import 'package:movie_app/models/genre.dart';
import 'package:movie_app/models/company.dart';

class MovieEntity extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final int? budget;
  final List<Genre>? genres;
  final List? genreIds;
  final String? homepage;
  final int? id;
  final String? imdbId;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<Company>? productionCompanies;
  final String? releaseDate;
  final int? revenue;
  final int? runtime;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  const MovieEntity({
    this.adult,
    this.backdropPath,
    this.budget,
    this.genres,
    this.genreIds,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        budget,
        genres,
        genreIds,
        homepage,
        id,
        imdbId,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        releaseDate,
        revenue,
        runtime,
        status,
        title,
        voteAverage,
        voteCount,
      ];
}
