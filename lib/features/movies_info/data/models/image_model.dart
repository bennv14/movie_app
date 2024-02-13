import 'dart:convert';

import 'package:movie_app/features/movies_info/domain/entities/image_entity.dart';

class ImageModel extends ImageEntity {
  const ImageModel({String? filePath, double? height, double? width, double? aspectRatio})
      : super(
          filePath: filePath,
          height: height,
          width: width,
          aspectRatio: aspectRatio,
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'file_path': filePath,
      'aspect_ratio': aspectRatio,
      'width': width,
      'height': height,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      filePath: map['file_path'] != null ? map['file_path'] as String : null,
      aspectRatio: map['aspect_ratio'] != null ? map['aspect_ratio'] as double : null,
      width: map['width'].toDouble(),
      height: map['height'].toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) =>
      ImageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
