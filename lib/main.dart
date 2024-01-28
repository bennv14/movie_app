import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/config/theme/theme.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/favourite_movies_bloc/favourite_movies_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/controller/favourite_movies.dart';
import 'package:movie_app/features/movies_info/presentation/pages/favourite_movies/favourite_movies_screen.dart';
import 'package:movie_app/features/movies_info/presentation/pages/home/home_screen.dart';
import 'package:movie_app/features/movies_info/presentation/pages/search/srearch_screen.dart';
import 'package:movie_app/features/movies_info/presentation/pages/sidebar/sidebar.dart';
import 'package:movie_app/features/movies_info/presentation/pages/user_detail/user_detail.dart';
import 'package:movie_app/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initDependencies();
  final f = FavouriteMovies.instance;
  await f.getFavouriteMovies();
  log(f.movies.toString());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ),
  );

  runApp(
    BlocProvider(
      create: (context) =>
          getIt.get<FavouriteMoviesBloc>()..add(InitialFavouriteMovies()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Widget> _pages = [
    const HomeScreen(),
    const FavouriteMoviesScreen(),
    const UserDetailScreen(),
  ];

  final List<String> titles = ["Home Screen", "Favourite Movies", "User"];
  int _pageSelected = 0;

  void changePageSelected(int page) {
    setState(() {
      _pageSelected = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: theme(),
      home: Scaffold(
        appBar: buildAppBar(context),
        drawer: SideBar(
          changePage: changePageSelected,
        ),
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
