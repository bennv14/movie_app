import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/review.dart';

class ReviewsTab extends StatelessWidget {
  final List<Review> reviews;
  const ReviewsTab({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: defaultPadding,
            ),
            child: Text(
              "Comments: ",
              style: headerMedium,
            ),
          )
        ],
      ),
    );
  }
}
