import 'package:flutter/material.dart';

class CustomTextFromField extends StatelessWidget {
  final TextStyle? style;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? subfixIcon;
  final Color? fillColor;
  final InputBorder? focusedBorder;
  final InputBorder? border;
  final EdgeInsets? contentPadding;
  final Color? cursorColor;
  final bool obscureText;

  const CustomTextFromField({
    super.key,
    this.style,
    this.hintText,
    this.border,
    this.contentPadding,
    this.cursorColor,
    this.fillColor,
    this.focusedBorder,
    this.hintStyle,
    this.prefixIcon,
    this.subfixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: cursorColor,
      obscureText: obscureText,
      style: style,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        isDense: true,
        contentPadding: contentPadding,
        prefixIcon: prefixIcon,
        suffixIcon: subfixIcon,
        filled: true,
        fillColor: fillColor,
        focusedBorder: focusedBorder,
        border: border,
      ),
    );
  }
}
