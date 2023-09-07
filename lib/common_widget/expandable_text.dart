import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  const ExpandableText({super.key, required this.text, this.maxLines = 4});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late bool isShowLess;
  @override
  void initState() {
    super.initState();
    isShowLess = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: textStyle,
          maxLines: isShowLess ? widget.maxLines : null,
          overflow: isShowLess ? TextOverflow.ellipsis : null,
        ),
        InkWell(
          onTap: ontap,
          child: Text(
            isShowLess ? "Show more" : "Show less",
            style: headerSmall.copyWith(color: secondaryColor),
          ),
        ),
      ],
    );
  }

  void ontap() {
    setState(() {
      isShowLess = !isShowLess;
    });
  }
}
