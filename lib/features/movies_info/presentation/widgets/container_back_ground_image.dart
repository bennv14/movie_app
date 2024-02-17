import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/domain/entities/image_entity.dart';

class ContainerBackGroundImage extends StatelessWidget {
  const ContainerBackGroundImage({
    super.key,
    required this.image,
    this.child,
    this.borderRadius,
    this.alignment,
    this.padding,
    this.height,
    this.width,
  });

  final ImageEntity image;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding,
      width: width,
      height: height,
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
