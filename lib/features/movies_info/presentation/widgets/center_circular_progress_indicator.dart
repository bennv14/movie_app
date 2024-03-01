import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constants.dart';

class CenterCircularProgressIndicator extends StatelessWidget {
  final Color color;
  final double? value;
  final Color? backgroundColor;
  const CenterCircularProgressIndicator({
    super.key,
    this.color = secondaryColor,
    this.value,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: secondaryColor,
        value: value,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
