import 'package:flutter/material.dart';

Container borderImage(
        {required Image image,
        required double height,
        required double width,
        required BorderRadius borderRadius}) =>
    Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius,
      ),
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: image,
      ),
    );
