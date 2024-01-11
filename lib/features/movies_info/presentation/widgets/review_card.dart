import 'package:flutter/material.dart';
import 'package:movie_app/common_widget/expandable_text.dart';
import 'package:movie_app/common_widget/image_border.dart';
import 'package:movie_app/common_widget/rating_vote.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/review.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        color: secondaryColor.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
          const SizedBox(height: defaultPadding / 2),
          ExpandableText(text: review.content ?? ""),
          const SizedBox(height: defaultPadding / 2),
          SizedBox(
            width: 65,
            height: 25,
            child: ratingVote(voteAverage: review.rating.toString()),
          )
        ],
      ),
    );
  }

  Row header() {
    return Row(
      children: [
        borderImage(
          image: createImage(review.avatarPath),
          height: 60,
          width: 60,
          borderRadius: const BorderRadius.all(
            Radius.circular(360),
          ),
        ),
        const SizedBox(
          width: defaultPadding / 2,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.author ?? "No name",
                style: headerMedium,
              ),
              const SizedBox(
                height: defaultPadding / 6,
              ),
              Text(
                showTime(review.createdAt!),
                style: textStyle,
              )
            ],
          ),
        ),
      ],
    );
  }

  String showTime(DateTime dateTime) {
    final now = DateTime.now();
    final timeDifference = now.difference(dateTime);
    if (timeDifference.inHours < 24) {
      return "${timeDifference.inHours} giờ";
    } else if (timeDifference.inDays <= 7) {
      return "${timeDifference.inDays} ngày";
    } else if (now.year == dateTime.year) {
      return "Ngày ${dateTime.day.toString().padLeft(2, '0')} tháng ${dateTime.month.toString().padLeft(2, '0')}";
    }
    return "Ngày ${dateTime.day.toString().padLeft(2, '0')} tháng ${dateTime.month.toString().padLeft(2, '0')} năm ${dateTime.year.toString().padLeft(4, '0')}";
  }
}
