import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/search_movies_bloc/search_movies_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/pages/search/widgets/search_body.dart';
import 'package:movie_app/injection_container.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => getIt.get<SearchMoviesBloc>(),
        child: const SearchBody(),
      ),
    );
  }
}
