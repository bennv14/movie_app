import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/genres_bloc/genres_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/movies_bloc/movies_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/pages/home/widgets/body.dart';
import 'package:movie_app/features/movies_info/presentation/pages/search/srearch_screen.dart';
import 'package:movie_app/injection_container.dart';
import 'dart:developer';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<MoviesBloc>(
            create: (context) => MoviesBloc(getIt())..add(InitMovies()),
          ),
          BlocProvider<GenresBloc>(
            create: (context) => GenresBloc(getIt())..add(GetGenresEvent()),
          ),
        ],
        child: const Body(),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        padding: const EdgeInsets.only(left: defaultPadding),
        icon: SvgPicture.asset(
          'assets/icons/menu.svg',
          width: 40,
          height: 40,
        ),
        onPressed: () {
          log('press menu button', name: 'movie_app:home');
        },
      ),
      actions: <Widget>[
        IconButton(
          padding: const EdgeInsets.only(right: defaultPadding),
          icon: SvgPicture.asset(
            'assets/icons/search.svg',
            width: 50,
            height: 50,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => const SearchScreen()),
              ),
            );
          },
        ),
      ],
    );
  }
}
