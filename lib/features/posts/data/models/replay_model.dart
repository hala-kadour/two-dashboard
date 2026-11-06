import 'package:two_dashboard/features/posts/domain/entities/reply_entity.dart';

class ReplyModel extends ReplyEntity {
  final int id;
  final String fullName;
  final String email;
  final String phone;
  final String cv;

  ReplyModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.cv,
  }) : super(
         id: id,
         fullName: fullName,
         email: email,
         phone: phone,
         cvFile: cv,
       );

  factory ReplyModel.fromJson(Map<String, dynamic> json) => ReplyModel(
    id: json["id"],
    fullName: json["full_name"],
    email: json["email"],
    phone: json["phone"],
    cv: json["cv"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "email": email,
    "phone": phone,
    "cv": cv,
  };
}
