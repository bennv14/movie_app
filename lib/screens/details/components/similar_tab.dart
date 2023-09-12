import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/similar_bloc/similar_bloc.dart';
import 'package:movie_app/common_widget/movie_card.dart';
import 'package:movie_app/constants.dart';

class SimilarTab extends StatefulWidget {
  const SimilarTab({super.key});

  @override
  State<SimilarTab> createState() => _SimilarTabState();
}

class _SimilarTabState extends State<SimilarTab> {
  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimilarBloc, SimilarState>(
      builder: (context, state) {
        switch (state.status) {
          case SimilarStatus.initial:
            return const Center(
              child: CircularProgressIndicator(color: secondaryColor),
            );
          case SimilarStatus.waiting:
            int length = state.similars.length;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: ListView.builder(
                itemCount: length + 1,
                itemBuilder: (context, index) {
                  if (index == length) {
                    return const Center(
                      child: CircularProgressIndicator(color: secondaryColor),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    child: MovieCard(movie: state.similars[index]),
                  );
                },
              ),
            );
          case SimilarStatus.success:
            int length = state.similars.length;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: ListView.builder(
                itemCount: length,
                itemBuilder: (context, index) {
                  if (index == length - 1) {
                    context.read<SimilarBloc>().add(FetchDataSimilarEvent());
                  }
                  return Padding(
                      padding: const EdgeInsets.only(bottom: defaultPadding),
                      child: MovieCard(movie: state.similars[index]));
                },
              ),
            );
          case SimilarStatus.failure:
            int length = state.similars.length;

            return ListView.builder(
              itemCount: length + 1,
              itemBuilder: (context, index) {
                if (index == length) {
                  return const Center(
                    child: Text(
                      "Fail",
                      style: headerLarge,
                    ),
                  );
                }

                return MovieCard(movie: state.similars[index]);
              },
            );
        }
      },
    );
  }
}
