import 'package:movie_app/features/movies_info/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  ReviewModel({
    String? author,
    String? name,
    String? username,
    String? avatarPath,
    double? rating,
    String? content,
    DateTime? createdAt,
    String? id,
    DateTime? updatedAt,
    String? url,
  }) : super(
          author: author,
          name: name,
          username: username,
          avatarPath: avatarPath,
          rating: rating,
          content: content,
          createdAt: createdAt,
          id: id,
          updatedAt: updatedAt,
          url: url,
        );

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        author: json["author"],
        name: json["author_details"]["name"],
        username: json["author_details"]["username"],
        avatarPath: json["author_details"]["avatar_path"],
        rating: json["author_details"]["rating"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "name": name,
        "username": username,
        "avatar_path": avatarPath,
        "rating": rating,
        "content": content,
        "created_at": createdAt!.toIso8601String(),
        "id": id,
        "updated_at": updatedAt!.toIso8601String(),
        "url": url,
      };
}
