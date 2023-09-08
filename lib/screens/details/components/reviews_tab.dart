import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/api/movie_api.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/review.dart';

class ReviewTab extends StatefulWidget {
  final Movie movie;
  const ReviewTab({super.key, required this.movie});

  @override
  State<ReviewTab> createState() => _ReviewTabState();
}

class _ReviewTabState extends State<ReviewTab> {
  late Function getReviews;
  late Future<List<Review>> reviewsFuture;
  late List<Review> reviews;
  late bool reachMax;
  @override
  void initState() {
    super.initState();
    reachMax = false;
    // getReviews = MovieAPI.getReviews(id: widget.movie.id!);
    reviewsFuture = getReviews();
    reviews = [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: reviewsFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text(
              "None data",
              style: headerMedium,
            );
          case ConnectionState.waiting:
            if (snapshot.hasData) {
              List<Widget> reviewCards = [];
              for (var review in snapshot.data!) {
                reviewCards.add(ReviewCard(review: review));
              }
              return ReviewList(widgets: reviewCards);
            } else {
              return const Center(
                child: CircularProgressIndicator(color: secondaryColor),
              );
            }

          case ConnectionState.active:
            if (snapshot.hasData) {
              List<Widget> reviewCards = [];
              for (var review in snapshot.data!) {
                reviewCards.add(ReviewCard(review: review));
              }
              return ReviewList(widgets: reviewCards);
            } else {
              return const Center(
                child: CircularProgressIndicator(color: secondaryColor),
              );
            }
          case ConnectionState.done:
            if (snapshot.hasData) {
              List<Widget> reviewCards = [];
              for (var review in snapshot.data!) {
                reviewCards.add(ReviewCard(review: review));
              }
              return ReviewList(widgets: reviewCards);
            } else {
              return const Center(
                child: CircularProgressIndicator(color: secondaryColor),
              );
            }
        }
      },
    );
  }
}

class ReviewList extends StatefulWidget {
  final List<Widget> widgets;
  const ReviewList({super.key, required this.widgets});

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  late final controller;
  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    controller.addListener(
      () {
        if (controller.position.maxScrollExtent == controller.offset) {
          log(name: "add reviews", "add review");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text("Comments: ${widget.widgets.length}"),
        ),
        ListView(
          controller: controller,
          padding: const EdgeInsets.only(
              bottom: defaultPadding, left: defaultPadding, right: defaultPadding),
          children: widget.widgets,
        ),
      ],
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          review.content ?? "No content",
          style: textStyle,
        ),
      ],
    );
  }
}

class RevieweHeader extends StatelessWidget {
  final String reviewerName;
  final Widget reviewerImage;
  final DateTime datePost;
  const RevieweHeader({
    super.key,
    required this.reviewerName,
    required this.reviewerImage,
    required this.datePost,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        reviewerImage,
        Expanded(
          child: Column(
            children: [
              Text(
                reviewerName,
                style: headerSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
