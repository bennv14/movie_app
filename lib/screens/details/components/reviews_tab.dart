import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/reviews_bloc/reviews_bloc.dart';
import 'package:movie_app/constants.dart';
import 'review_card.dart';

class ReviewTab extends StatelessWidget {
  const ReviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsBloc, ReviewsState>(
      builder: (context, state) {
        switch (state.status) {
          case ReviewStatus.initial:
            log(name: "initial", state.reviews.length.toString());
            return const Center(
              child: CircularProgressIndicator(color: secondaryColor),
            );

          case ReviewStatus.success:
            log(name: "success", state.reviews.length.toString());

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
                      "Đánh giá: ${state.totalReviews}",
                      style: headerMedium,
                    ),
                  );
                }
                if (index == state.reviews.length) {
                  context.read<ReviewsBloc>().add(FetchData());
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
            log(name: "failure", state.reviews.length.toString());

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
                      "Đánh giá: ${state.totalReviews}",
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
                try {
                  return Container(
                    margin: const EdgeInsets.only(
                      bottom: defaultPadding,
                      left: defaultPadding,
                      right: defaultPadding,
                    ),
                    child: ReviewCard(review: state.reviews[index - 1]),
                  );
                } on RangeError {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: defaultPadding,
                        right: defaultPadding,
                        bottom: defaultPadding,
                      ),
                      child: Text(
                        "Đánh giá: ${state.totalReviews}",
                        style: headerMedium,
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.only(
                        bottom: defaultPadding,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(color: secondaryColor),
                      ),
                    );
                  }
                }
              },
            );
          case ReviewStatus.hasReachMax:
            log(name: "hasReachMax", state.reviews.length.toString());

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
                      "Đánh giá: ${state.totalReviews}",
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
}
