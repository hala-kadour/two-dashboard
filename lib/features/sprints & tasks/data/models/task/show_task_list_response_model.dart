import 'dart:convert';

import 'package:two_dashboard/features/sprints%20&%20tasks/data/models/task/task_model.dart';

ShowTaskListResponseModel showTaskListResponseModelFromJson(String str) =>
    ShowTaskListResponseModel.fromJson(json.decode(str));

String showTaskListResponseModelToJson(ShowTaskListResponseModel data) =>
    json.encode(data.toJson());

class ShowTaskListResponseModel {
  final int status;
  final String msg;
  final List<TaskModel> data;

  ShowTaskListResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory ShowTaskListResponseModel.fromJson(Map<String, dynamic> json) =>
      ShowTaskListResponseModel(
        status: json["status"],
        msg: json["msg"],
        data: List<TaskModel>.from(
          json["data"].map((x) => TaskModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
