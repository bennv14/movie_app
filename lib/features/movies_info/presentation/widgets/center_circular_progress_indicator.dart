import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constants.dart';

class CenterCircularProgressIndicator extends StatelessWidget {
  final Color color;
  final double? value;
  const CenterCircularProgressIndicator({
    super.key,
    this.color = secondaryColor,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: secondaryColor,
        value: value,
      ),
    );
  }
}
