import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/theme/theme.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/dashbroad.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/favourite_movies_bloc/favourite_movies_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/pages/sign_in_screen/sign_in_screen.dart';
import 'package:movie_app/firebase_options.dart';
import 'package:movie_app/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt.get<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) =>
              getIt.get<FavouriteMoviesBloc>()..add(InitialFavouriteMovies()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        theme: theme(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              getIt.get<AuthBloc>().add(LoggedIn(snapshot.data!));
              return const Dashbroard();
            } else {
              return const SignInSceen();
            }
          },
        ),
      ),
    );
  }
}
