import 'package:flutter/material.dart';
import 'package:movie_app/api/movie_api.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/models/movie.dart';

class DetailScreen extends StatefulWidget {
  final MovieEntity movie;

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
            return const Text("Dfa");
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
