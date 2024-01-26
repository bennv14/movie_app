import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/domain/entities/genre_entity.dart';

class ViewListGenres extends StatelessWidget {
  const ViewListGenres({
    super.key,
    required this.genres,
  });

  final List<GenreEntity> genres;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        padding: const EdgeInsets.only(right: defaultPadding),
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) => GenreDetail(genre: genres[index].name ?? "Null"),
      ),
    );
  }
}

class GenreDetail extends StatelessWidget {
  final String genre;
  const GenreDetail({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(
        left: defaultPadding,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 4,
      ),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black26)),
      child: Text(
        genre,
        style: const TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
