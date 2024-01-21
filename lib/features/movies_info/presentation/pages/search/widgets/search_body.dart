import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/search_movies_bloc/search_movies_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/pages/search/widgets/search_bar_delegate_header.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/movie_card.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverPersistentHeader(
          floating: true,
          pinned: true,
          delegate: SearchBarDelegateHeader(maxHeight: 100),
        ),
      ],
      body: BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
        builder: (context, state) {
          switch (state.status) {
            case SearchMoviesStatus.init:
              return Container();
            case SearchMoviesStatus.loading:
              return ListView.builder(
                itemCount: state.movies.length + 1,
                itemBuilder: (context, index) {
                  try {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: defaultPadding, bottom: defaultPadding),
                      child: MovieCard(movie: state.movies[index]),
                    );
                  } on RangeError {
                    return const Center(
                      child: CircularProgressIndicator(color: secondaryColor),
                    );
                  }
                },
              );
            case SearchMoviesStatus.success:
              final length = state.movies.length;
              if (length == 0) {
                return const Center(
                  child: Text(
                    "Không có phim phù hợp!",
                    style: headerLarge,
                  ),
                );
              }
              return ListView.builder(
                itemCount: state.movies.length + 1,
                itemBuilder: (context, index) {
                  try {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: defaultPadding, bottom: defaultPadding),
                      child: MovieCard(movie: state.movies[index]),
                    );
                  } on RangeError {
                    context.read<SearchMoviesBloc>().add(FetchSearchMovies());
                    return null;
                  }
                },
              );
            case SearchMoviesStatus.error:
              return const Text("eror");
          }
        },
      ),
    );
  }
}
