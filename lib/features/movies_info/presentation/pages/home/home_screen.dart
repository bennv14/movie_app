import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/genres_bloc/genres_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/movies_bloc/movies_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/pages/home/widgets/body.dart';
import 'package:movie_app/injection_container.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return Scaffold(
      backgroundColor: Colors.white,
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
}
