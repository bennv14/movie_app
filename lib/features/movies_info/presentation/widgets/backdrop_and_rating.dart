import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/favourite_movies_bloc/favourite_movies_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/controller/favourite_movies.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/image_border.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/rating_vote.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/releasedate_runtime.dart';
import 'package:movie_app/injection_container.dart';

class BackdropTitle extends StatelessWidget {
  final MovieEntity movie;

  const BackdropTitle({
    super.key,
    required this.movie,
  });

  void clickBookmark() {
    final favouriteMovies = FavouriteMovies.instance;
    if (favouriteMovies.movies.contains(movie)) {}
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heightBackdrop = width * 9 / 16;

    return Column(
      children: [
        Stack(
          fit: StackFit.loose,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                borderImage(
                  image: createImage(movie.backdropPath),
                  height: heightBackdrop,
                  width: width,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: defaultPadding / 2,
                    left: defaultPadding + 100 + defaultPadding / 2,
                    right: defaultPadding / 2,
                  ),
                  height: 75,
                  width: width,
                  child: Text(
                    movie.title ?? "No title",
                    style: titleMovie,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            Positioned(
              top: heightBackdrop - 40,
              right: 20,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 4,
                  right: 8,
                  bottom: 4,
                ),
                height: 25,
                width: 65,
                decoration: const BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: ratingVote(
                    voteAverage: movie.voteAverage?.toStringAsFixed(1) ?? "null"),
              ),
            ),
            Positioned(
              top: heightBackdrop - 75,
              left: defaultPadding,
              child: borderImage(
                image: createImage(movie.posterPath),
                height: 150,
                width: 100,
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
            ),
            Positioned(
                top: defaultPadding * 1.5,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ))),
            Positioned(
              top: defaultPadding * 1.5,
              right: 0,
              child: BlocBuilder<FavouriteMoviesBloc, FavouriteMoviesState>(
                builder: (context, state) {
                  return TextButton(
                    onPressed: () {
                      _onClickBookmark(state.movies);
                    },
                    child: _buildBookmark(state.movies),
                  );
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: ReleasedateRuntime(
            release: movie.releaseDate ?? "null",
            runtime: movie.runtime ?? 0,
          ),
        )
      ],
    );
  }

  Icon _buildBookmark(List<MovieEntity> movies) {
    return Icon(
      movies.contains(movie) ? Icons.bookmark_added : Icons.bookmark_add,
      color: Colors.white,
    );
  }

  void _onClickBookmark(List<MovieEntity> movies) {
    if (movies.contains(movie)) {
      getIt.get<FavouriteMoviesBloc>().add(RemoveFavouriteMovies(movie));
    } else {
      getIt.get<FavouriteMoviesBloc>().add(AddFavouriteMovies(movie));
    }
  }
}
