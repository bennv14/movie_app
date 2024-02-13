class SearchMoviesRequest {
  final String query;
  final String language;
  final int page;
  final String? region;
  final int? year;
  final bool includeAdult;
  final int? primaryReleaseYear;

  const SearchMoviesRequest({
    required this.query,
    this.language = 'vi',
    this.page = 1,
    this.region = 'vn',
    this.includeAdult = true,
    this.primaryReleaseYear,
    this.year,
  });
}
