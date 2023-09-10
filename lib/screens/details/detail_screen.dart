import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/api/movie_api.dart';
import 'package:movie_app/bloc/reviews_bloc/reviews_bloc.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/screens/details/components/body.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;

  const DetailScreen({super.key, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final Future<Movie> movie;
  @override
  void initState() {
    super.initState();
    movie = MovieAPI.getDetails(id: widget.movie.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: movie,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocProvider(
              create: (context) =>
                  ReviewsBloc(MovieAPI.getReviews(id: snapshot.data?.id ?? 0))
                    ..add(Initial()),
              child: Body(
                movie: snapshot.data ?? Movie(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color: secondaryColor),
            );
          }
        },
      ),
    );
  }
}

class DetailScreens extends StatelessWidget {
  const DetailScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
