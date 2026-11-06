import 'dart:convert';

import 'package:two_dashboard/features/sprints%20&%20tasks/data/models/sprint/sprint.dart';

CreateBacklogTasksSprintResponseModel
createBacklogTasksSprintResponseModelFromJson(String str) =>
    CreateBacklogTasksSprintResponseModel.fromJson(json.decode(str));

String createBacklogTasksSprintResponseModelToJson(
  CreateBacklogTasksSprintResponseModel data,
) => json.encode(data.toJson());

class CreateBacklogTasksSprintResponseModel {
  final int status;
  final String msg;
  final Sprint data;

  CreateBacklogTasksSprintResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory CreateBacklogTasksSprintResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => CreateBacklogTasksSprintResponseModel(
    status: json["status"],
    msg: json["msg"],
    data: Sprint.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}
