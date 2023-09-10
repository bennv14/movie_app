import 'package:flutter/material.dart';
import 'package:movie_app/common_widget/cast_card.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/cast.dart';

class ListCast extends StatelessWidget {
  final List<Cast> casts;
  const ListCast({super.key, required this.casts});

  @override
  Widget build(BuildContext context) {
    List<Widget> castView = [];
    castView.add(
      Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Text(
          "Diễn viên: ${casts.length}",
          style: headerMedium,
        ),
      ),
    );

    for (var cast in casts) {
      castView.add(
        Container(
          margin: const EdgeInsets.only(
            left: defaultPadding,
            right: defaultPadding,
            bottom: defaultPadding,
          ),
          child: CastCard(cast: cast),
        ),
      );
    }
    return ListView(
      children: castView,
    );
  }
}
