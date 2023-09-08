import 'package:flutter/material.dart';
import 'package:movie_app/common_widget/image_border.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/cast.dart';

class CastCard extends StatelessWidget {
  final Cast cast;
  const CastCard({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        borderImage(
          image: createImage(cast.profilePath),
          height: 70,
          width: 70,
          borderRadius: const BorderRadius.all(
            Radius.circular(360),
          ),
        ),
        const SizedBox(
          width: defaultPadding,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cast.name ?? "Null",
                style: headerMedium,
              ),
              const SizedBox(
                height: defaultPadding / 4,
              ),
              Text(cast.character ?? "Null"),
            ],
          ),
        ),
      ],
    );
  }

  Image createImage(String? url) {
    if (url == null) {
      return Image.asset(
        "assets/images/no-image.png",
        fit: BoxFit.fitHeight,
      );
    } else {
      return Image.network(
        urlImage(url),
        fit: BoxFit.cover,
      );
    }
  }
}
