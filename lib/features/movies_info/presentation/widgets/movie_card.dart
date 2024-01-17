import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_info/presentation/pages/detail_movies/detail_screen.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/image_border.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedElevation: 0.2,
      openElevation: 0.2,
      closedBuilder: (context, action) => buildMovieCard(),
      openBuilder: (context, action) => DetailScreen(movie: movie),
    );
  }

  Widget buildMovieCard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            borderImage(
              image: createImage(movie.posterPath),
              height: 150,
              width: 100,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            Positioned(
              top: defaultPadding / 2,
              right: defaultPadding / 2,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding / 3,
                  vertical: defaultPadding / 4,
                ),
                decoration: const BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Text(
                  movie.voteAverage!.toStringAsFixed(1),
                  style: headerSmall.copyWith(color: Colors.amber),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: defaultPadding,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: defaultPadding,
              ),
              Text(
                movie.title!,
                style: headerMedium,
              ),
              const SizedBox(
                height: defaultPadding / 4,
              ),
              Text(
                movie.releaseDate!.length > 4
                    ? movie.releaseDate!.substring(0, 4)
                    : "null",
                style: textStyle,
              )
            ],
          ),
        ),
        TextButton(onPressed: () {}, child: const Icon(Icons.bookmark_add))
      ],
    );
  }
}
