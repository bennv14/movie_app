import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/core/resources/data_state.dart';
import 'package:movie_app/features/movies_info/data/dto/movie_image.dart';
import 'package:movie_app/features/movies_info/data/dto/my_response.dart';
import 'package:movie_app/features/movies_info/data/models/movie_model.dart';
import 'package:movie_app/features/movies_info/domain/usecases/get_images_movies_usecase.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/center_circular_progress_indicator.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/expandable_text.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/information.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/view_list_genres.dart';
import 'package:movie_app/injection_container.dart';

import 'image_library.dart';

class AboutTab extends StatefulWidget {
  final MovieModel movie;
  const AboutTab({super.key, required this.movie});

  @override
  State<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> with AutomaticKeepAliveClientMixin {
  late Future<DataState<MyResponse<ImagesMovie>>> imagesMovie;

  get height => null;

  @override
  void initState() {
    super.initState();
    imagesMovie = getIt<GetImagesMovieUsecase>()(params: widget.movie.id!);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final widthPoster = (MediaQuery.of(context).size.width - defaultPadding * 3) / 11 * 3;
    const ratio = 8 / 3;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            widget.movie.tagline?.trim() == ""
                ? "Không có tagline"
                : widget.movie.tagline ?? "Null",
            style: headerLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: ExpandableText(
            text: widget.movie.overview?.trim() == ""
                ? "Không có overview"
                : widget.movie.overview?.trim() ?? "Null",
            maxLines: 4,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Text(
            "Thể loại",
            style: headerLarge,
          ),
        ),
        ViewListGenres(genres: widget.movie.genres ?? []),
        const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Text(
            "Thông tin",
            style: headerLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: defaultPadding,
          ),
          child: Information(movie: widget.movie),
        ),
        FutureBuilder(
          future: imagesMovie,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final posters = snapshot.data!.data!.responseData!.posters;
              final backdrops = snapshot.data!.data!.responseData!.backdrops;
              if (posters.isEmpty && backdrops.isEmpty) {
                return Container();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: defaultPadding,
                      left: defaultPadding,
                      bottom: defaultPadding,
                    ),
                    child: Text(
                      "Media",
                      style: headerLarge,
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: defaultPadding,
                      ),
                      posters.isNotEmpty
                          ? ImageLibrary(
                              width: widthPoster,
                              height: widthPoster / posterRatio,
                              images: posters,
                            )
                          : Container(),
                      const SizedBox(
                        width: defaultPadding,
                      ),
                      backdrops.isNotEmpty
                          ? ImageLibrary(
                              width: widthPoster * ratio,
                              height: widthPoster * ratio / backdropRatio,
                              images: backdrops,
                            )
                          : Container(),
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const CenterCircularProgressIndicator();
            }
          },
        ),
        const SizedBox(
          height: defaultPadding,
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
