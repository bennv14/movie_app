import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/api/movies_api.dart';
import 'package:movie_app/bloc/genres-bloc/genres_bloc.dart';
import 'package:movie_app/bloc/movies_bloc/movies_bloc.dart';
import 'package:movie_app/constants.dart';
import 'components/body.dart';
import 'dart:developer';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MoviesBloc(
              MoviesAPI.getMovies(
                uri: MoviesAPI.uriNowPlaying,
                language: 'vi',
                region: "vn",
              ),
            )..add(InitMoves()),
          ),
          BlocProvider<GenresBloc>(
            create: (context) => GenresBloc()
              ..add(
                InitGenresEvent(),
              ),
          ),
        ],
        child: const Body(),
      ),
    );
  }

  AppBar buildAppBar() {
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
          log('press menu buttom', name: 'movie_app:home');
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
            log('press search button', name: 'movie_app:home');
          },
        ),
      ],
    );
  }
}
