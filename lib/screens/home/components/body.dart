import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/genres-bloc/genres_bloc.dart';
import 'package:movie_app/bloc/movies_bloc/movies_bloc.dart';
import 'package:movie_app/common_widget/carousel.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movie.dart';
import 'categoris.dart';
import 'genres.dart';
import 'movie_card.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<int> genresSelected = [];

  @override
  void initState() {
    super.initState();
  }

  void fetchMovies() {
    context.read<MoviesBloc>().add(FetchMovies());
  }

  bool checkGenresMovie(Movie movie, GenresBloc genresBloc) {
    if (genresBloc.state.genresSelected.isEmpty) {
      return true;
    } else {
      log(name: "Check genres", genresBloc.state.genresSelected.toString());
      List genresMovie = movie.genreIds ?? [];
      for (var genreID in genresSelected) {
        if (genresMovie.contains(genreID)) {
          return true;
        }
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    log(name: "Home", "openhome");
    return Column(
      children: [
        const CategoryList(),
        BlocBuilder<GenresBloc, GenresState>(builder: (context, state) {
          switch (state.status) {
            case GenresStatus.waiting:
              return const Center(
                child: CircularProgressIndicator(color: secondaryColor),
              );
            case GenresStatus.success:
              return Genres(
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
        }),
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
                  onAddPage: fetchMovies,
                );
              case MoviesStatus.failure:
                return const Center(
                  child: Text(
                    "Has Error",
                    style: headerLarge,
                  ),
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
                  onAddPage: fetchMovies,
                );
            }
          },
        ),
      ],
    );
  }
}
