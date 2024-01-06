import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final String? author;
  final String? name;
  final String? username;
  final String? avatarPath;
  final double? rating;
  final String? content;
  final DateTime? createdAt;
  final String? id;
  final DateTime? updatedAt;
  final String? url;

  const ReviewEntity({
    this.author,
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  @override
  List<Object?> get props => [
        author,
        name,
        username,
        avatarPath,
        rating,
        content,
        createdAt,
        id,
        updatedAt,
        url,
      ];
}
