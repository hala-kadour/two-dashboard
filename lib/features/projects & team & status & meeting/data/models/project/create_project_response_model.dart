import 'dart:convert';

import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/project_model.dart';

CreateProjectResponseModel createProjectResponseModelFromJson(String str) =>
    CreateProjectResponseModel.fromJson(json.decode(str));

String createProjectResponseModelToJson(CreateProjectResponseModel data) =>
    json.encode(data.toJson());

class CreateProjectResponseModel {
  final int status;
  final String msg;
  final ProjectModel data;

  CreateProjectResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory CreateProjectResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateProjectResponseModel(
        status: json["status"],
        msg: json["msg"],
        data: ProjectModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}
