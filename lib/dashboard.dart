import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/data/repository/firebase_repository_impl.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/favourite_movies_bloc/favourite_movies_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/pages/favourite_movies/favourite_movies_screen.dart';
import 'package:movie_app/features/movies_info/presentation/pages/home/home_screen.dart';
import 'package:movie_app/features/movies_info/presentation/pages/search/search_screen.dart';
import 'package:movie_app/features/movies_info/presentation/pages/sidebar/sidebar.dart';
import 'package:movie_app/features/movies_info/presentation/pages/user_detail/user_detail.dart';
import 'package:movie_app/injection_container.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Widget> _pages = [
    const HomeScreen(),
    const FavouriteMoviesScreen(),
    const UserDetailScreen(),
  ];

  final List<String> titles = ["Home Screen", "Favourite Movies", "User"];
  int _pageSelected = 0;

  void _changePageSelected(int page) {
    setState(() {
      _pageSelected = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          getIt.get<FavouriteMoviesBloc>().add(
                InitialFavouriteMovies(FirebaseRepositoryImpl(state.user)),
              );
        }
      },
      child: Scaffold(
        appBar: buildAppBar(context),
        drawer: SideBar(changePage: _changePageSelected),
        body: _pages[_pageSelected],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(titles[_pageSelected]),
      titleTextStyle: headerLarge,
      centerTitle: true,
      elevation: 0,
      leading: Builder(builder: (context) {
        return IconButton(
          padding: const EdgeInsets.only(left: defaultPadding),
          icon: SvgPicture.asset(
            'assets/icons/menu.svg',
            width: 40,
            height: 40,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      }),
      actions: <Widget>[
        Builder(builder: (context) {
          return IconButton(
            padding: const EdgeInsets.only(right: defaultPadding),
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              width: 40,
              height: 40,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: ((context) => const SearchScreen())),
              );
            },
          );
        }),
      ],
    );
  }
}
