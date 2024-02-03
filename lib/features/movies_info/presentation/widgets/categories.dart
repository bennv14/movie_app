import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/movies_bloc/movies_bloc.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    super.key,
  });

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedCategory = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: defaultPadding / 2),
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => buildCategory(index, context),
      ),
    );
  }

  Padding buildCategory(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCategory = index;
            if (selectedCategory == 0) {
              context.read<MoviesBloc>().add(
                    ChangeURI(
                      uri: uriNowPlaying,
                    ),
                  );
            } else if (selectedCategory == 1) {
              context.read<MoviesBloc>().add(
                    ChangeURI(
                      uri: uriPopular,
                    ),
                  );
            } else if (selectedCategory == 2) {
              context.read<MoviesBloc>().add(
                    ChangeURI(
                      uri: uriTopRate,
                    ),
                  );
            } else if (selectedCategory == 3) {
              context.read<MoviesBloc>().add(
                    ChangeURI(
                      uri: uriUpcoming,
                    ),
                  );
            }
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categories[index],
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: index == selectedCategory
                      ? textColor
                      : Colors.black.withOpacity(0.4)),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: defaultPadding / 3),
              height: 6,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: index == selectedCategory ? secondaryColor : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
