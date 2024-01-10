import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common_widget/carousel.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/genres_bloc/genres_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/movies_bloc/movies_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/categoris.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/view_list_genres.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/movie_card.dart';
import 'package:movie_app/injection_container.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<int> genresSelected = [];

  void fetchMovies() {
    getIt.get<MoviesBloc>().add(FetchMovies());
  }

  // bool checkGenresMovie(MovieEntity movie, GenresBloc genresBloc) {
  //   if (genresBloc.state.genresSelected.isEmpty) {
  //     return true;
  //   } else {
  //     log(name: "Check genres", genresBloc.state.genresSelected.toString());
  //     List genresMovie = movie.genreIds ?? [];
  //     for (var genreID in genresSelected) {
  //       if (genresMovie.contains(genreID)) {
  //         return true;
  //       }
  //     }
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    log(name: "Home", "open");
    return Column(
      children: [
        const CategoryList(),
        BlocBuilder<GenresBloc, GenresState>(
          builder: (context, state) {
            switch (state.status) {
              case GenresStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(color: secondaryColor),
                );
              case GenresStatus.success:
                return ViewListGenres(
                  genres: state.genres,
                );
              case GenresStatus.failure:
                return const Center(
                  child: Text(
                    "Error",
                    style: headerLarge,
                  ),
                );
            }
          },
        ),
        BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            switch (state.status) {
              case MoviesStatus.waiting:
                List<Widget> moviesCards = [];
                for (var movie in state.movies) {
                  moviesCards.add(MovieCard(movie: movie));
                }
                return Carousel(
                  widgets: moviesCards
                    ..add(
                      const Center(
                        child: CircularProgressIndicator(color: secondaryColor),
                      ),
                    ),
                  onAddPage: () {
                    fetchMovies();
                  },
                );

              case MoviesStatus.failure:
                List<Widget> moviesCards = [];
                for (var movie in state.movies) {
                  moviesCards.add(MovieCard(movie: movie));
                }
                return Carousel(
                  widgets: moviesCards
                    ..add(
                      const Center(
                        child: Text(
                          "Error",
                          style: headerLarge,
                        ),
                      ),
                    ),
                  onAddPage: () {
                    fetchMovies();
                  },
                );
              case MoviesStatus.initial:
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: secondaryColor),
                  ),
                );
              case MoviesStatus.success:
                List<Widget> moviesCards = [];
                for (var movie in state.movies) {
                  moviesCards.add(MovieCard(movie: movie));
                }
                return Carousel(
                  widgets: moviesCards,
                  onAddPage: () {
                    fetchMovies();
                  },
                );
            }
          },
        ),
      ],
    );
  }
}
