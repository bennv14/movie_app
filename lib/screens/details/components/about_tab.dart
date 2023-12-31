import 'package:flutter/material.dart';
import 'package:movie_app/common_widget/expandable_text.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/screens/details/components/genres.dart';
import 'package:movie_app/screens/details/components/information.dart';

class AboutTab extends StatelessWidget {
  final Movie movie;
  const AboutTab({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            movie.tagline?.trim() == "" ? "Không có tagline" : movie.tagline ?? "Null",
            style: headerMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: ExpandableText(
            text: movie.overview?.trim() == ""
                ? "Không có overview"
                : movie.overview?.trim() ?? "Null",
            maxLines: 4,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Text(
            "Thể loại",
            style: headerMedium,
          ),
        ),
        Genres(genres: movie.genres ?? []),
        const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Text(
            "Thông tin",
            style: headerMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: defaultPadding,
            bottom: defaultPadding,
          ),
          child: Information(movie: movie),
        ),
      ],
    );
  }
}
