import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:animations/animations.dart';
import 'package:movie_app/features/movies_info/presentation/pages/detail_movies/detail_screen.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
      child: OpenContainer(
        closedElevation: 0.2,
        openElevation: 0.2,
        closedBuilder: (context, action) => BuildMovieCard(movie: movie),
        openBuilder: (context, action) => DetailScreen(movie: movie),
      ),
    );
  }
}

class BuildMovieCard extends StatelessWidget {
  const BuildMovieCard({
    super.key,
    required this.movie,
  });

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: createImage(movie.posterPath),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
          child: Text(
            movie.title!,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/star_fill.svg",
              height: 20,
            ),
            const SizedBox(width: defaultPadding / 2),
            Text(
              "${movie.voteAverage}",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            )
          ],
        )
      ],
    );
  }
}
