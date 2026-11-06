import 'dart:convert';

import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/project_model.dart';

ShowProjectsResponseModel showProjectsResponseModelFromJson(String str) =>
    ShowProjectsResponseModel.fromJson(json.decode(str));

String showProjectsResponseModelToJson(ShowProjectsResponseModel data) =>
    json.encode(data.toJson());

class ShowProjectsResponseModel {
  final int status;
  final String msg;
  final List<ProjectModel> data;

  ShowProjectsResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory ShowProjectsResponseModel.fromJson(Map<String, dynamic> json) =>
      ShowProjectsResponseModel(
        status: json["status"],
        msg: json["msg"],
        data: List<ProjectModel>.from(
          json["data"].map((x) => ProjectModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
