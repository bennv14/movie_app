import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/data/data_sources/remote/movie_api_service.dart';
import 'package:movie_app/features/movies_info/data/dto/my_response.dart';
import 'package:movie_app/features/movies_info/data/models/movie_model.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_info/presentation/pages/detail_movies/body.dart';
import 'package:movie_app/injection_container.dart';

class DetailScreen extends StatefulWidget {
  final MovieEntity movie;

  const DetailScreen({super.key, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final Future<MyResponse<MovieModel>> response;
  @override
  void initState() {
    super.initState();
    response = getIt.get<MovieAPISerVice>().getDetailsMovie(id: widget.movie.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: response,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Body(
              movie: snapshot.data!.responseData!,
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
