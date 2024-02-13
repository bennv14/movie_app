import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/domain/entities/image_entity.dart';

class ContainerBackGroundImage extends StatelessWidget {
  const ContainerBackGroundImage({
    super.key,
    required this.widthPoster,
    required this.ratio,
    required this.image,
    this.child,
    this.borderRadius,
    this.alignment,
    this.padding,
  });

  final double widthPoster;
  final double ratio;
  final ImageEntity image;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding,
      width: widthPoster * ratio,
      height: widthPoster * ratio / backdropRatio,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultPadding / 4),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2),
            BlendMode.darken,
          ),
          image: NetworkImage(
            urlImage(image.filePath!),
          ),
        ),
      ),
      child: child,
    );
  }
}
