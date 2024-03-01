import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constants.dart';

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
  final Color cursorColor;
  final bool obscureText;
  final TextEditingController? controller;
  final bool? enabled;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final AutovalidateMode? autovalidateMode;
  final String? labelText;
  final TextStyle? labelStyle;

  const CustomTextFromField({
    super.key,
    this.style,
    this.hintText,
    this.border = _border,
    this.contentPadding,
    this.cursorColor = secondaryColor,
    this.fillColor,
    this.focusedBorder = _focusBorder,
    this.hintStyle,
    this.prefixIcon,
    this.subfixIcon,
    this.obscureText = false,
    this.controller,
    this.enabled,
    this.validator,
    this.onChanged,
    this.autovalidateMode,
    this.labelText,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      autovalidateMode: autovalidateMode,
      validator: validator,
      enabled: enabled,
      cursorColor: cursorColor,
      obscureText: obscureText,
      controller: controller,
      style: style,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle,
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

  static const _border = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(defaultPadding / 2),
    ),
    borderSide: BorderSide(color: borderTFFColor),
  );

  static const _focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(defaultPadding / 2),
    ),
    borderSide: BorderSide(color: secondaryColor),
  );
}
