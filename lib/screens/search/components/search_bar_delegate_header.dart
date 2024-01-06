import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';

class SearchBarDelegateHeader extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  bool ishasInput = false;
  TextEditingController textController = TextEditingController();

  SearchBarDelegateHeader({required this.maxHeight});

  void backNavigator(BuildContext context) {
    Navigator.of(context).pop();
  }

  void clearInp() {
    textController.text = "";
    ishasInput = false;
  }

  Widget btnClearInput() => InkWell(
        onTap: clearInp,
        child: const Icon(
          Icons.close,
          color: Colors.black,
        ),
      );

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: secondaryColor,
      child: Padding(
        padding: const EdgeInsets.only(
          top: defaultPadding * 2,
          bottom: defaultPadding,
          left: defaultPadding,
          right: defaultPadding,
        ),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back),
            ),
            const SizedBox(width: defaultPadding),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  if (value.isEmpty) {
                    ishasInput = false;
                  } else {
                    ishasInput = true;
                  }
                },
                controller: textController,
                cursorColor: Colors.black,
                style: headerMedium,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle: headerMedium.copyWith(color: Colors.black54),
                  suffixIcon: ishasInput ? btnClearInput() : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
