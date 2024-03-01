import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/domain/entities/image_entity.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/container_back_ground_image.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/view_image_library.dart';

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
    return Padding(
      padding: const EdgeInsets.all(0),
      child: OpenContainer(
        transitionDuration: const Duration(milliseconds: 550),
        closedElevation: 0,
        openElevation: 0,
        openBuilder: (context, action) => openLibrary(),
        closedBuilder: (context, action) => represent(),
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(defaultPadding / 2),
          ),
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

  Widget openLibrary() {
    return ViewImageLibrary(images: images);
  }
}
