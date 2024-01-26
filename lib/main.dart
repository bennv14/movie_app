import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/theme/theme.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/favourite_movies_bloc/favourite_movies_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/controller/favourite_movies.dart';
import 'package:movie_app/features/movies_info/presentation/pages/home/home_screen.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: theme(),
      home: const HomeScreen(),
    );
  }
}
