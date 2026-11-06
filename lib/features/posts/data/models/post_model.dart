import 'package:two_dashboard/features/posts/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  final int id;
  final String description;
  final String image;
  final int? status;
  final List<Reply> replies;

  PostModel({
    required this.id,
    required this.description,
    required this.image,
    required this.status,
    required this.replies,
  }) : super(postId: id, body: description, poster: image, active: status);

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json["id"],
    description: json["description"],
    image: json["image"],
    status: json["status"] ?? 1,
    replies: List<Reply>.from(json["replies"].map((x) => Reply.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "image": image,
    "status": status,
    "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
  };
}

class Reply {
  final int id;
  final String fullName;
  final String email;
  final String phone;
  final String cv;
  final int preAccept;
  final int postId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Reply({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.cv,
    required this.preAccept,
    required this.postId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
    id: json["id"],
    fullName: json["full_name"],
    email: json["email"],
    phone: json["phone"],
    cv: json["cv"],
    preAccept: json["pre_accept"],
    postId: json["post_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "email": email,
    "phone": phone,
    "cv": cv,
    "pre_accept": preAccept,
    "post_id": postId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
