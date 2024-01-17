import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/similar_movies_bloc/similar_movies_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/movie_card.dart';

class SimilarTab extends StatefulWidget {
  const SimilarTab({super.key});

  @override
  State<SimilarTab> createState() => _SimilarTabState();
}

class _SimilarTabState extends State<SimilarTab> {
  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimilarMoviesBloc, SimilarMoviesState>(
      builder: (context, state) {
        switch (state.status) {
          case SimilarMoviesStatus.init:
            return const Center(
              child: CircularProgressIndicator(color: secondaryColor),
            );
          case SimilarMoviesStatus.loading:
            int length = state.movies.length;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: ListView.builder(
                itemCount: length + 1,
                itemBuilder: (context, index) {
                  try {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: defaultPadding),
                      child: MovieCard
                        (movie: state.movies[index]),
                    );
                  } on RangeError {
                    return const Padding(
                      padding: EdgeInsets.only(
                        bottom: defaultPadding,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(color: secondaryColor),
                      ),
                    );
                  }
                },
              ),
            );
          case SimilarMoviesStatus.success:
            int length = state.movies.length;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: ListView.builder(
                itemCount: length + 1,
                itemBuilder: (context, index) {
                  try {
                    return Padding(
                        padding: const EdgeInsets.only(bottom: defaultPadding),
                        child: MovieCard(movie: state.movies[index]));
                  } on RangeError {
                    context.read<SimilarMoviesBloc>().add(FetchSimilarMovies());
                    return null;
                  }
                },
              ),
            );
          case SimilarMoviesStatus.error:
            int length = state.movies.length;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: ListView.builder(
                itemCount: length + 1,
                itemBuilder: (context, index) {
                  try {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: defaultPadding),
                      child: MovieCard(movie: state.movies[index]),
                    );
                  } on RangeError {
                    return const Center(
                      child: Text(
                        "Error",
                        style: headerLarge,
                      ),
                    );
                  }
                },
              ),
            );
        }
      },
    );
  }
}
