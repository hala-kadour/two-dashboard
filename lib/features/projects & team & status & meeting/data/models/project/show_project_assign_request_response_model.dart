import 'dart:convert';

import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/project_assign_request_model.dart';

ShowProjectAssignRequestResponseModel
showProjectAssignRequestResponseModelFromJson(String str) =>
    ShowProjectAssignRequestResponseModel.fromJson(json.decode(str));

String showProjectAssignRequestResponseModelToJson(
  ShowProjectAssignRequestResponseModel data,
) => json.encode(data.toJson());

class ShowProjectAssignRequestResponseModel {
  final int status;
  final String msg;
  final List<ProjectAssignRequestModel> data;

  ShowProjectAssignRequestResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory ShowProjectAssignRequestResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => ShowProjectAssignRequestResponseModel(
    status: json["status"],
    msg: json["msg"],
    data: List<ProjectAssignRequestModel>.from(
      json["data"].map((x) => ProjectAssignRequestModel.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
