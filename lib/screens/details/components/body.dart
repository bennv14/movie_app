import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/api/movie_api.dart';
import 'package:movie_app/bloc/recommendations_bloc/recommendations_bloc.dart';
import 'package:movie_app/bloc/reviews_bloc/reviews_bloc.dart';
import 'package:movie_app/bloc/similar_bloc/similar_bloc.dart';
import 'package:movie_app/common_widget/sliver_appbar_delegate.dart';
import 'package:movie_app/common_widget/sliver_tabbar_delegate.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/cast.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/review.dart';
import 'package:movie_app/screens/details/components/about_tab.dart';
import 'package:movie_app/screens/details/components/list_cast.dart';
import 'package:movie_app/screens/details/components/recommendations_tab.dart';
import 'package:movie_app/screens/details/components/reviews_tab.dart';
import 'package:movie_app/screens/details/components/similar_tab.dart';

class Body extends StatefulWidget {
  final Movie movie;
  const Body({super.key, required this.movie});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final Future<List<Cast>> casts;
  late final Future<List<Review>> reviews;

  @override
  void initState() {
    super.initState();
    casts = MovieAPI.getCasts(id: widget.movie.id!);
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
              delegate: SliverTabBarDelegate(builTapBar()),
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
              future: casts,
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
                      return ListCast(casts: snapshot.data ?? []);
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
              create: (context) => ReviewsBloc(
                MovieAPI.getReviews(id: widget.movie.id!),
              )..add(Initial()),
              child: const ReviewTab(),
            ),
            BlocProvider(
              create: (context) => RecommendationsBloc(
                MovieAPI.getRecommendations(id: widget.movie.id!),
              )..add(InitialRecommendationsEvent()),
              child: const RecommendationsTab(),
            ),
            BlocProvider(
              create: (context) => SimilarBloc(
                MovieAPI.getSimilar(id: widget.movie.id!),
              )..add(InitialSimilarEvent()),
              child: const SimilarTab(),
            ),
          ],
        ),
      ),
    );
  }

  TabBar builTapBar() {
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
      tabs: tabBarMovie
          .map((e) => Tab(
                text: e,
              ))
          .toList(),
    );
  }
}
