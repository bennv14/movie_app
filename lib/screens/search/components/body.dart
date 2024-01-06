import 'package:flutter/material.dart';
import 'package:movie_app/screens/search/components/search_bar_delegate_header.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverPersistentHeader(
          delegate: SearchBarDelegateHeader(maxHeight: 100),
        ),
      ],
      body: Container(),
    );
  }
}
