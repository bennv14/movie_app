// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movie_app/features/movies_info/domain/entities/image_entity.dart';

class ImagesMovie {
  final List<ImageEntity> posters;
  final List<ImageEntity> backdrops;

  ImagesMovie({
    required this.posters,
    required this.backdrops,
  });
}
