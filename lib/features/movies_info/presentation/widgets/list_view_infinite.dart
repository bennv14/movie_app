import 'package:flutter/material.dart';

class ListViewInfinite extends StatefulWidget {
  final List<Widget> widgets;
  final Function funcAddWidgets;

  const ListViewInfinite({
    super.key,
    required this.widgets,
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
      () async {
        if (controller.position.maxScrollExtent == controller.offset) {
          await widget.funcAddWidgets();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      children: widget.widgets,
    );
  }
}
