import 'package:genericjson/pagination/comment.dart';

class Post{
  final int id;
  final String noiDung;
  final DateTime created;
  final String userName;
  final String displayName;
  String? imageUrl;
  final List<Comment> comments;

  Post({required this.id,
    required this.noiDung,
    required this.created,
    required this.userName,
    required this.displayName,
    this.imageUrl,
    required this.comments
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      noiDung: json['noiDung'],
      created: DateTime.parse(json['created']),
      userName: json['userName'],
      displayName: json['displayName'],
      imageUrl: json["imageUrl"],
      comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    );
  }

  static Post fromJsonModel(Map<String, dynamic> json) => Post.fromJson(json);
}