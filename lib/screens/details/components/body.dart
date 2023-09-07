import 'package:flutter/material.dart';
import 'package:movie_app/api/api.dart';
import 'package:movie_app/common_widget/expandable_text.dart';
import 'package:movie_app/common_widget/sliver_appbar_delegate.dart';
import 'package:movie_app/common_widget/sliver_tabbar_delegate.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/cast.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/screens/details/components/about.dart';
import 'package:movie_app/screens/details/components/list_cast.dart';

class Body extends StatefulWidget {
  final Movie movie;
  const Body({super.key, required this.movie});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<List<Cast>> casts;

  @override
  void initState() {
    super.initState();
    casts = API.getCastsMovie(widget.movie.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
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
                  child: About(movie: widget.movie),
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
                          return SingleChildScrollView(
                            child: ListCast(casts: snapshot.data ?? []),
                          );
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
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ExpandableText(
                      text: widget.movie.overview ?? "",
                    ),
                  ),
                ),
                const Center(
                  child: CircularProgressIndicator(color: secondaryColor),
                ),
                const Center(
                  child: CircularProgressIndicator(color: secondaryColor),
                ),
              ],
            )),
      );
    });
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
