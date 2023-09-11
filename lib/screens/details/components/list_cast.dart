import 'package:flutter/material.dart';
import 'package:movie_app/common_widget/cast_card.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/cast.dart';

class ListCast extends StatelessWidget {
  final List<Cast> casts;
  const ListCast({super.key, required this.casts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: casts.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(
                left: defaultPadding, right: defaultPadding, bottom: defaultPadding),
            child: Text(
              "Diễn viên: ${casts.length}",
              style: headerMedium,
            ),
          );
        }
        return Container(
          margin: const EdgeInsets.only(
            left: defaultPadding,
            right: defaultPadding,
            bottom: defaultPadding,
          ),
          child: CastCard(cast: casts[index - 1]),
        );
      },
    );
  }
}
