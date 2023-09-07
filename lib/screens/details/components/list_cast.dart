import 'package:flutter/material.dart';
import 'package:movie_app/common_widget/cast_card.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/cast.dart';

class ListCast extends StatelessWidget {
  final List<Cast> casts;
  const ListCast({super.key, required this.casts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Diễn viên: ${casts.length}",
            style: headerMedium,
          ),
        ),
        ...casts
            .map((e) => Container(
                margin: const EdgeInsets.only(
                    left: defaultPadding,
                    right: defaultPadding,
                    bottom: defaultPadding),
                child: CastCard(cast: e)))
            .toList(),
      ],
    );
  }
}
