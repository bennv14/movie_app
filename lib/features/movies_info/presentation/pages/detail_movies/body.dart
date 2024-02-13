import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/data/dto/movie_request.dart';
import 'package:movie_app/features/movies_info/data/dto/my_response.dart';
import 'package:movie_app/features/movies_info/data/models/movie_model.dart';
import 'package:movie_app/features/movies_info/domain/entities/cast_entity.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_casts_movie_usecase.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_recommend_movies_usecase.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/recommend_movies_bloc/recommend_movies_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/reviews_movie_bloc/reviews_movie_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/similar_movies_bloc/similar_movies_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/about_tab.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/list_cast.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/recommendations_tab.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/reviews_tab.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/similar_tab.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/sliver_appbar_delegate.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/sliver_tabbar_delegate.dart';
import 'package:movie_app/injection_container.dart';

class Body extends StatefulWidget {
  final MovieModel movie;
  const Body({super.key, required this.movie});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final Future<DataState<MyResponse<List<CastEntity>>>> castsData;

  @override
  void initState() {
    super.initState();
    castsData =
        getIt.get<GetCastsMovieUseCase>()(params: MovieRequest(id: widget.movie.id!));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabBarMovie.length,
      child: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverPersistentHeader(
              delegate: SliverAppBarDelegate(
                movie: widget.movie,
              ),
              pinned: true,
            ),
            SliverPersistentHeader(
              delegate: SliverTabBarDelegate(buildTapBar()),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: AboutTab(movie: widget.movie),
            ),
            FutureBuilder(
              future: castsData,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Expanded(
                        child: Center(
                          child: Text(snapshot.error.toString()),
                        ),
                      );
                    } else {
                      return ListCast(casts: snapshot.data!.data!.responseData!);
                    }
                  default:
                    return const Center(
                      child: CircularProgressIndicator(
                        color: secondaryColor,
                      ),
                    );
                }
              },
            ),
            BlocProvider(
              create: (context) =>
                  ReviewsMovieBloc(getIt())..add(InitReviewsMovie(widget.movie.id!)),
              child: const ReviewTab(),
            ),
            BlocProvider(
              create: (context) =>
                  RecommendMoviesBloc(getIt.get<GetRecommendMoviesUseCase>())
                    ..add(InitRecommendMovies(widget.movie.id!)),
              child: const RecommendationsTab(),
            ),
            BlocProvider(
              create: (context) =>
                  SimilarMoviesBloc(getIt())..add(InitSimilarMovies(widget.movie.id!)),
              child: const SimilarTab(),
            ),
          ],
        ),
      ),
    );
  }

  TabBar buildTapBar() {
    return TabBar(
      isScrollable: true,
      labelColor: Colors.black,
      indicatorColor: secondaryColor,
      labelStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 4,
      tabs: tabBarMovie.map((e) => Tab(text: e)).toList(),
    );
  }
}
