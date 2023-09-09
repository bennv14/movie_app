import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/common_widget/image_border.dart';
import 'package:movie_app/common_widget/rating_vote.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/screens/details/components/releasedate_runtime.dart';

class BackdropTitle extends StatelessWidget {
  final Movie movie;

  const BackdropTitle({
    super.key,
    required this.movie,
  });

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
                image: createImage(urlImage(movie.posterPath!)),
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
              child: TextButton(
                onPressed: () {
                  log("add");
                },
                child: Icon(
                  Icons.bookmark,
                  color: Colors.white.withOpacity(0.9),
                ),
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

  Image createImage(String? url) {
    if (url == null) {
      return Image.asset(
        "assets/images/no-image.png",
        fit: BoxFit.fitHeight,
      );
    } else {
      return Image.network(
        urlImage(url),
        fit: BoxFit.cover,
      );
    }
  }
}
