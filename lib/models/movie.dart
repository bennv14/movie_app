import 'package:movie_app/models/genre.dart';
import 'package:movie_app/models/company.dart';

class Movie {
  bool? adult;
  String? backdropPath;
  int? budget;
  List<Genre>?  genres;
  List? genreIds;
  String? homepage;
  int? id;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  List<Company>? productionCompanies;
  String? releaseDate;
  int? revenue;
  int? runtime;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Movie(
      {adult,
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
      voteCount});

  Movie.fullDetail(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];

    budget = json['budget'];
    if (json['genres'] != null) {
       genres = < Genre>[];
      json['genres'].forEach((v) {
         genres!.add( Genre.fromJson(v));
      });
    }
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'].toDouble();
    posterPath = json['poster_path'];

    if (json['production_companies'] != null) {
      productionCompanies = <Company>[];
      json['production_companies'].forEach((v) {
        productionCompanies!.add(Company.fromJson(v));
      });
    }

    releaseDate = json['release_date'];
    revenue = json['revenue'];
    runtime = json['runtime'];

    status = json['status'];
    tagline = json['tagline'];
    title = json['title'];
    voteAverage = json['vote_average'].toDouble();
    voteCount = json['vote_count'];
  }

  Movie.importantDetail(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'];
    homepage = json['homepage'];
    id = json['id'];
    overview = json['overview'];
    popularity = json['popularity'].toDouble();
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    voteAverage = json['vote_average'].toDouble();
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['budget'] = budget;
    if ( genres != null) {
      data['genres'] =  genres!.map((v) => v.toJson()).toList();
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
      data['production_companies'] =
          productionCompanies!.map((v) => v.toJson()).toList();
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
}


