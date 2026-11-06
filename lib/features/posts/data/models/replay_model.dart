import 'package:two_dashboard/features/posts/domain/entities/reply_entity.dart';

class ReplyModel extends ReplyEntity {
  ReplyModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.phone,
    required String cv,
  }) : super(cvFile: cv);

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
    "cv": cvFile,
  };
}
