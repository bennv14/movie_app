import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';

class ListViewInfinite extends StatefulWidget {
  final int totalResults;
  final List<Widget> widgets;
  final Function funcAddWidgets;

  const ListViewInfinite({
    super.key,
    required this.widgets,
    required this.totalResults,
    required this.funcAddWidgets,
  });

  @override
  State<ListViewInfinite> createState() => _ListViewInfiniteState();
}

class _ListViewInfiniteState extends State<ListViewInfinite> {
  late final ScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    controller.addListener(
      () {
        if (controller.position.maxScrollExtent == controller.offset) {
          log(name: "add reviews", "add review");
          widget.funcAddWidgets();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Comments: ${widget.totalResults}",
            style: headerMedium,
          ),
          Expanded(
            child: ListView(
              children: widget.widgets,
            ),
          ),
        ],
      ),
    );
  }
}
