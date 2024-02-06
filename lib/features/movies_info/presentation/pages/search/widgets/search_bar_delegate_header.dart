import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/search_movies_bloc/search_movies_bloc.dart';

class SearchBarDelegateHeader extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  bool isHasInput = false;
  TextEditingController textController = TextEditingController();
  late SearchMoviesBloc _searchMoviesBloc;

  SearchBarDelegateHeader({required this.maxHeight});

  void backNavigator(BuildContext context) {}

  void _onClearInp() {
    textController.text = "";
    isHasInput = false;
  }

  void _onSubmitInp(String text) {
    log(name: "SearchMovieScreen", "query: $text");
    _searchMoviesBloc.add(SearchMovies(text));
  }

  Widget btnClearInput() => InkWell(
        onTap: _onClearInp,
        child: const Icon(
          Icons.close,
          color: Colors.black,
        ),
      );

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    _searchMoviesBloc = context.read<SearchMoviesBloc>();
    return Container(
      color: Colors.white,
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
                    isHasInput = false;
                  } else {
                    isHasInput = true;
                  }
                },
                controller: textController,
                cursorColor: secondaryColor,
                cursorWidth: 3,
                cursorRadius: const Radius.circular(defaultPadding),
                cursorOpacityAnimates: true,
                style: textStyle,
                onSubmitted: _onSubmitInp,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search...",
                  hintStyle: headerMedium.copyWith(color: Colors.black45),
                  suffixIcon: isHasInput ? btnClearInput() : null,
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
  double get minExtent => maxHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
