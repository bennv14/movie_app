import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/reviews_bloc/reviews_bloc.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movie.dart';
import 'review_card.dart';

class ReviewTab extends StatefulWidget {
  final Movie movie;
  final ScrollController controller;
  const ReviewTab({super.key, required this.movie, required this.controller});

  @override
  State<ReviewTab> createState() => _ReviewTabState();
}

class _ReviewTabState extends State<ReviewTab> {
  @override
  void initState() {
    super.initState();
    ReviewsBloc reviewsBloc = context.read<ReviewsBloc>();
    widget.controller.addListener(() {
      if (!reviewsBloc.state.hasReachMax) {
        if (widget.controller.offset == widget.controller.position.maxScrollExtent) {
          reviewsBloc.add(FetchData());
        }
      }
    });
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
            return ListView.builder(
              itemCount: state.reviews.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: defaultPadding,
                      right: defaultPadding,
                      bottom: defaultPadding,
                    ),
                    child: Text(
                      "Comments: ${state.totalReviews}",
                      style: headerMedium,
                    ),
                  );
                }
                return Container(
                  margin: const EdgeInsets.only(
                    bottom: defaultPadding,
                    left: defaultPadding,
                    right: defaultPadding,
                  ),
                  child: ReviewCard(review: state.reviews[index - 1]),
                );
              },
            );

          case ReviewStatus.failure:
            int length = state.reviews.length;
            return ListView.builder(
              itemCount: length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: defaultPadding,
                      right: defaultPadding,
                      bottom: defaultPadding,
                    ),
                    child: Text(
                      "Comments: ${state.totalReviews}",
                      style: headerMedium,
                    ),
                  );
                }
                if (index == length + 1) {
                  return const Padding(
                    padding: EdgeInsets.only(
                      left: defaultPadding,
                      right: defaultPadding,
                      bottom: defaultPadding,
                    ),
                    child: Center(
                      child: Text(
                        "Error",
                        style: headerLarge,
                      ),
                    ),
                  );
                }
                return Container(
                  margin: const EdgeInsets.only(
                    bottom: defaultPadding,
                    left: defaultPadding,
                    right: defaultPadding,
                  ),
                  child: ReviewCard(review: state.reviews[index - 1]),
                );
              },
            );

          case ReviewStatus.waiting:
            int length = state.reviews.length;
            return ListView.builder(
              itemCount: length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: defaultPadding,
                      right: defaultPadding,
                      bottom: defaultPadding,
                    ),
                    child: Text(
                      "Comments: ${state.totalReviews}",
                      style: headerMedium,
                    ),
                  );
                }
                if (index == length + 1) {
                  return const Padding(
                    padding: EdgeInsets.only(
                      left: defaultPadding,
                      right: defaultPadding,
                      bottom: defaultPadding,
                    ),
                    child: Center(
                      child: CircularProgressIndicator(color: secondaryColor),
                    ),
                  );
                }
                return Container(
                  margin: const EdgeInsets.only(
                    bottom: defaultPadding,
                    left: defaultPadding,
                    right: defaultPadding,
                  ),
                  child: ReviewCard(review: state.reviews[index - 1]),
                );
              },
            );
          case ReviewStatus.hasReachMax:
            return ListView.builder(
              itemCount: state.reviews.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: defaultPadding,
                      right: defaultPadding,
                      bottom: defaultPadding,
                    ),
                    child: Text(
                      "Comments: ${state.totalReviews}",
                      style: headerMedium,
                    ),
                  );
                }
                return Container(
                  margin: const EdgeInsets.only(
                    bottom: defaultPadding,
                    left: defaultPadding,
                    right: defaultPadding,
                  ),
                  child: ReviewCard(review: state.reviews[index - 1]),
                );
              },
            );
        }
      },
    );
  }

  Widget view(List<Widget> widgets) {
    return SingleChildScrollView(
      controller: widget.controller,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets,
        ),
      ),
    );
  }
}
