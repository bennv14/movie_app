import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/features/movies_info/data/models/movie_model.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/expandable_text.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/information.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/view_list_genres.dart';

class AboutTab extends StatefulWidget {
  final MovieModel movie;
  const AboutTab({super.key, required this.movie});

  @override
  State<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            widget.movie.tagline?.trim() == "" ? "Không có tagline" : widget.movie.tagline ?? "Null",
            style: headerMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: ExpandableText(
            text: widget.movie.overview?.trim() == ""
                ? "Không có overview"
                : widget.movie.overview?.trim() ?? "Null",
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
        ViewListGenres(genres: widget.movie.genres ?? []),
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
          child: Information(movie: widget.movie),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
