import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final String? filePath;
  final double? aspectRatio;
  final double? width;
  final double? height;

  const ImageEntity({this.filePath, this.aspectRatio, this.width, this.height});

  @override
  List<Object?> get props => [filePath, aspectRatio, width, height];
}
