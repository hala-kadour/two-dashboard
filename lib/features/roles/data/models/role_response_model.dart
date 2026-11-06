import 'dart:convert';
import 'package:hive/hive.dart';

part 'role_response_model.g.dart';

RoleResponesModel roleResponesModelFromJson(String str) =>
    RoleResponesModel.fromJson(json.decode(str));

String roleResponesModelToJson(RoleResponesModel data) =>
    json.encode(data.toJson());

class RoleResponesModel {
  final int status;
  final String msg;
  final List<RoleModel> data;

  RoleResponesModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory RoleResponesModel.fromJson(Map<String, dynamic> json) =>
      RoleResponesModel(
        status: json["status"],
        msg: json["msg"],
        data: List<RoleModel>.from(
          json["data"].map((x) => RoleModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

@HiveType(typeId: 1)
class RoleModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String role;

  RoleModel({required this.id, required this.role});

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      RoleModel(id: json["id"], role: json["role"]);

  Map<String, dynamic> toJson() => {"id": id, "role": role};
}
