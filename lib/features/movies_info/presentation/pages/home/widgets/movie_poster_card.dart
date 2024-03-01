import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:animations/animations.dart';
import 'package:movie_app/features/movies_info/presentation/pages/detail_movies/detail_screen.dart';

class MainMovieCard extends StatelessWidget {
  final MovieEntity movie;

  const MainMovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 550),
      closedElevation: 0,
      openElevation: 0,
      openColor: Colors.transparent,
      closedColor: Colors.transparent,
      closedBuilder: (context, action) => buildMovieCard(),
      openBuilder: (context, action) => DetailScreen(movie: movie),
    );
  }

  Widget buildMovieCard() {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(defaultPadding),
            child: cachedImage(movie.posterPath),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
          child: Text(
            movie.title!,
            overflow: TextOverflow.ellipsis,
            style: headerLarge,
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
              style: headerMedium,
            )
          ],
        )
      ],
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
            child: cachedImage(movie.posterPath),
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
