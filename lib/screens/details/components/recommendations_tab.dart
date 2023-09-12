import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/recommendations_bloc/recommendations_bloc.dart';
import 'package:movie_app/common_widget/movie_card.dart';
import 'package:movie_app/constants.dart';

class RecommendationsTab extends StatelessWidget {
  const RecommendationsTab({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendationsBloc, RecommendationsState>(
      builder: (context, state) {
        switch (state.status) {
          case RecommendationsStatus.initial:
            return const Center(
              child: CircularProgressIndicator(color: secondaryColor),
            );
          case RecommendationsStatus.waiting:
            int length = state.recommendations.length;
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
                    child: MovieCard(movie: state.recommendations[index]),
                  );
                },
              ),
            );
          case RecommendationsStatus.success:
            int length = state.recommendations.length;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: ListView.builder(
                itemCount: length,
                itemBuilder: (context, index) {
                  if (index == length - 1) {
                    context
                        .read<RecommendationsBloc>()
                        .add(FetchDataRecommendationsEvent());
                  }
                  return Padding(
                      padding: const EdgeInsets.only(bottom: defaultPadding),
                      child: MovieCard(movie: state.recommendations[index]));
                },
              ),
            );
          case RecommendationsStatus.failure:
            int length = state.recommendations.length;

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

                return MovieCard(movie: state.recommendations[index]);
              },
            );
        }
      },
    );
  }
}
