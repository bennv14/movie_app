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
          delegate: SearchBarDelegateHeader(maxHeight: 100),
        ),
      ],
      body: BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
        builder: (context, state) {
          switch (state.status) {
            case SearchMoviesStatus.init:
              return Container();
            case SearchMoviesStatus.loading:
              return const Center(
                child: CircularProgressIndicator(color: secondaryColor),
              );
            case SearchMoviesStatus.success:
              return ListView.builder(
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  return MovieCard(movie: state.movies[index]);
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
