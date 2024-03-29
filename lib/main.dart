import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/theme/theme.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/dashboard.dart';
import 'package:movie_app/features/movies_info/data/repository/firebase_repository_impl.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/favourite_movies_bloc/favourite_movies_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/controller/auth_strategy/googe_auth_strategy.dart';
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
          create: (context) => getIt.get<FavouriteMoviesBloc>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        theme: theme(),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final user = FirebaseAuth.instance.currentUser;
            if (state is Authenticated) {
              getIt
                  .get<FavouriteMoviesBloc>()
                  .add(InitialFavouriteMovies(FirebaseRepositoryImpl(state.user)));
              return const Dashboard();
            } else {
              if (user != null) {
                getIt
                    .get<FavouriteMoviesBloc>()
                    .add(InitialFavouriteMovies(FirebaseRepositoryImpl(user)));
                getIt.get<AuthBloc>().add(
                      LoggedIn(user, authStrategy: GoogleAuthentication()),
                    );

                return const Dashboard();
              }
              return const SignInScreen();
            }
          },
        ),
      ),
    );
  }
}
