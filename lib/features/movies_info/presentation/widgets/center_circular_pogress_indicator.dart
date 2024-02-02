import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constants.dart';

class CenterCircularProgressIndicator extends StatelessWidget {
  final Color color;
  const CenterCircularProgressIndicator({super.key, this.color = secondaryColor});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: secondaryColor),
    );
  }
}
