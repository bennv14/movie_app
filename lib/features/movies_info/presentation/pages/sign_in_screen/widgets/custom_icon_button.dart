import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Decoration? decoration;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final Widget icon;
  final VoidCallback? onPressed;
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.decoration,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      decoration: decoration,
      child: IconButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        icon: icon,
      ),
    );
  }
}
