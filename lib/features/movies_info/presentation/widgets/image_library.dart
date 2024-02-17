import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/domain/entities/image_entity.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/container_back_ground_image.dart';

class ImageLibrary extends StatelessWidget {
  const ImageLibrary({
    super.key,
    required this.images,
    this.height,
    this.width,
  });

  final List<ImageEntity> images;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 5500),
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      closedElevation: 0.5,
      openElevation: 2,
      openBuilder: (context, action) {
        log('open');
        return openLibrary(context);
      },
      closedBuilder: (context, action) {
        log('close');
        return represent();
      },
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
    );
  }

  Widget represent() {
    return ContainerBackGroundImage(
      height: height,
      width: width,
      padding: const EdgeInsets.only(
        left: defaultPadding / 2,
        bottom: defaultPadding / 4,
      ),
      image: images[0],
      borderRadius: BorderRadius.circular(defaultPadding / 4),
      alignment: Alignment.bottomLeft,
      child: Text(
        "${images.length} images",
        style: headerMedium.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget openLibrary(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          itemCount: images.length,
          itemBuilder: (context, index) {
            return createImage(images[index].filePath, fit: BoxFit.contain);
          },
        ),
        Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
