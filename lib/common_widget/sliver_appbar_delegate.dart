import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/features/movies_info/data/models/movie_model.dart';
import 'package:movie_app/screens/details/components/backdrop_and_rating.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final MovieModel movie;
  final double minHeight;
  final double maxHeight;
  SliverAppBarDelegate({required this.movie, this.minHeight = 85, this.maxHeight = 340});

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }

  bool appear(double shrinkOffset) => shrinkOffset / minHeight >= 2;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        buildAppBar(shrinkOffset),
        Positioned(
          top: -shrinkOffset,
          child: buildBackground(shrinkOffset, movie),
        ),
      ],
    );
  }

  Widget buildAppBar(double shrinkOffset) => Visibility(
        visible: appear(shrinkOffset),
        child: AppBar(
          backgroundColor: secondaryColor,
          elevation: 0,
          title: Text(
            movie.title ?? "No title",
            style: const TextStyle(color: Colors.black),
          ),
          leading: const BackButton(color: Colors.black),
          actions: [
            TextButton(
              onPressed: () {
                log("add");
              },
              child: const Icon(
                Icons.bookmark,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      );

  Widget buildBackground(double shrinkOffset, MovieModel movie) => Visibility(
        visible: !appear(shrinkOffset),
        child: BackdropTitle(movie: movie),
      );
}
