import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/recommend_movies_bloc/recommend_movies_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/movie_card.dart';

class RecommendationsTab extends StatefulWidget {
  const RecommendationsTab({super.key});

  @override
  State<RecommendationsTab> createState() => _RecommendationsTabState();
}

class _RecommendationsTabState extends State<RecommendationsTab> with AutomaticKeepAliveClientMixin{
  @override
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<RecommendMoviesBloc, RecommendMoviesState>(
      builder: (context, state) {
        switch (state.status) {
          case RecommendMoviesStatus.init:
            return const Center(
              child: CircularProgressIndicator(color: secondaryColor),
            );
          case RecommendMoviesStatus.loading:
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
                  } catch (e) {
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
          case RecommendMoviesStatus.success:
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
                    context.read<RecommendMoviesBloc>().add(FetchRecommendMovies());
                    // log('$index');
                    return null;
                  }
                },
              ),
            );
          case RecommendMoviesStatus.error:
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
                    return const Padding(
                      padding: EdgeInsets.only(bottom: defaultPadding),
                      child: Center(
                        child: Text(
                          "Fail",
                          style: headerLarge,
                        ),
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

  @override
  bool get wantKeepAlive => true;
}
