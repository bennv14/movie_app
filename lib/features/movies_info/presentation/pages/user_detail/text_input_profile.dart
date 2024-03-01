import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constants.dart';

class TextInputCustom extends StatefulWidget {
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final String? hintText;
  final TextEditingController? controller;
  final double? borderWidth;
  final BoxBorder? border;
  final BoxBorder? focusBoder;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final Color? cursorColor;

  const TextInputCustom({
    super.key,
    this.labelText,
    this.labelStyle,
    this.controller,
    this.style,
    this.borderWidth,
    this.border,
    this.borderRadius,
    this.hintText,
    this.hintStyle,
    this.contentPadding,
    this.focusBoder,
    this.cursorColor,
  });

  @override
  State<TextInputCustom> createState() => _TextInputProfileState();
}

class _TextInputProfileState extends State<TextInputCustom> {
  late final FocusNode _focusNode;
  bool _isFocused = false;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  void _onTap() {
    setState(() {
      _focusNode.requestFocus();
      _isFocused = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        padding: widget.contentPadding,
        decoration: BoxDecoration(
          border: _isFocused ? widget.border : widget.focusBoder ?? widget.border,
          borderRadius: widget.borderRadius,
        ),
        child: TextFormField(
          focusNode: _focusNode,
          controller: widget.controller,
          cursorColor: widget.cursorColor,
          style: widget.style,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: widget.labelStyle,
            contentPadding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            isDense: true,
          ),
        ),
      ),
    );
  }
}
