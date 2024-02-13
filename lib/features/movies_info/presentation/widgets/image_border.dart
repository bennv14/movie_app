import 'package:flutter/material.dart';

Container borderImage({
  required Image image,
  double? height,
  double? width,
  BorderRadius? borderRadius,
}) =>
    Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius,
      ),
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: image,
      ),
    );
