import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/reviews_bloc/reviews_bloc.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movie.dart';
import 'review_card.dart';

class ReviewTab extends StatefulWidget {
  final Movie movie;
  const ReviewTab({super.key, required this.movie});

  @override
  State<ReviewTab> createState() => _ReviewTabState();
}

class _ReviewTabState extends State<ReviewTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsBloc, ReviewsState>(
      builder: (context, state) {
        switch (state.status) {
          case ReviewStatus.initial:
            return const Center(
              child: CircularProgressIndicator(color: secondaryColor),
            );

          case ReviewStatus.success:
            List<Widget> widgets = [];
            widgets.add(
              Padding(
                padding: const EdgeInsets.only(bottom: defaultPadding),
                child: Text(
                  "Đánh giá: ${state.totalReviews}",
                  style: headerMedium,
                ),
              ),
            );
            for (var review in state.reviews) {
              widgets.add(
                Container(
                  margin: const EdgeInsets.only(bottom: defaultPadding),
                  child: ReviewCard(review: review),
                ),
              );
            }
            return view(widgets);

          case ReviewStatus.failure:
            List<Widget> widgets = [];
            widgets.add(
              Padding(
                padding: const EdgeInsets.only(bottom: defaultPadding),
                child: Text(
                  "Đánh giá: ${state.totalReviews}",
                  style: headerMedium,
                ),
              ),
            );
            for (var review in state.reviews) {
              widgets.add(
                Container(
                  margin: const EdgeInsets.only(bottom: defaultPadding),
                  child: ReviewCard(review: review),
                ),
              );
            }
            widgets.add(const Text("Fail"));
            return view(widgets);

          case ReviewStatus.waiting:
            List<Widget> widgets = [];
            widgets.add(Padding(
              padding: const EdgeInsets.only(bottom: defaultPadding),
              child: Text(
                "Đánh giá: ${state.totalReviews}",
                style: headerMedium,
              ),
            ));
            for (var review in state.reviews) {
              widgets.add(
                Container(
                  margin: const EdgeInsets.only(bottom: defaultPadding),
                  child: ReviewCard(review: review),
                ),
              );
            }
            widgets.add(const Center(
              child: CircularProgressIndicator(color: secondaryColor),
            ));
            return view(widgets);
        }
      },
    );
  }

  Widget view(List<Widget> widgets) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [...widgets],
      ),
    );
  }
}