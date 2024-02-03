import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/favourite_movies_bloc/favourite_movies_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/movie_card.dart';

class FavouriteMoviesScreen extends StatelessWidget {
  const FavouriteMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavouriteMoviesBloc, FavouriteMoviesState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: defaultPadding / 2),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 0,
                    left: defaultPadding,
                    right: defaultPadding,
                    bottom: defaultPadding,
                  ),
                  child: MovieCard(
                    movie: state.movies[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
