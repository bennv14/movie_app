import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/reviews_movie_bloc/reviews_movie_bloc.dart';
import 'review_card.dart';

class ReviewTab extends StatefulWidget {
  const ReviewTab({super.key});

  @override
  State<ReviewTab> createState() => _ReviewTabState();
}

class _ReviewTabState extends State<ReviewTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ReviewsMovieBloc, ReviewsMovieState>(
      builder: (context, state) {
        switch (state.status) {
          case ReviewsMovieStatus.init:
            return const Center(
              child: CircularProgressIndicator(color: secondaryColor),
            );

          case ReviewsMovieStatus.success:
            final length = state.reviews.length;
            if (length == 0) {
              return const Center(
                child: Text(
                  "Không có đánh giá!",
                  style: headerLarge,
                ),
              );
            }
            return ListView.builder(
              itemCount: length + 1,
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
                  context.read<ReviewsMovieBloc>().add(FetchReviewsMovie());
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

          case ReviewsMovieStatus.error:
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

          case ReviewsMovieStatus.loading:
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
                        "Đánh giá: ${state.reviews}",
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
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
