class Review {
  String? author;
  String? name;
  String? username;
  String? avatarPath;
  int? rating;
  String? content;
  DateTime? createdAt;
  String? id;
  DateTime? updatedAt;
  String? url;

  Review({
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

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        author: json["author"],
        name: json["name"],
        username: json["username"],
        avatarPath: json["avatar_path"],
        rating: json["rating"],
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
