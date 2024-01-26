import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/favourite_movies_bloc/favourite_movies_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/backdrop_and_rating.dart';
import 'package:movie_app/injection_container.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final MovieEntity movie;
  final double minHeight;
  final double maxHeight;
  SliverAppBarDelegate({
    required this.movie,
    this.minHeight = 85,
    this.maxHeight = 340,
  });

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
            BlocBuilder<FavouriteMoviesBloc, FavouriteMoviesState>(
              builder: (context, state) {
                return TextButton(
                  onPressed: () {
                    _onClickBookmark(state.movies);
                  },
                  child: _buildBookmark(state.movies),
                );
              },
            ),
          ],
        ),
      );

  Widget buildBackground(double shrinkOffset, MovieEntity movie) => Visibility(
        visible: !appear(shrinkOffset),
        child: BackdropTitle(movie: movie),
      );

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
