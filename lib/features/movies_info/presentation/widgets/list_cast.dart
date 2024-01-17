import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/features/movies_info/domain/entities/cast_entity.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/cast_card.dart';

class ListCast extends StatelessWidget {
  final List<CastEntity> casts;
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
