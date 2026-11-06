import 'dart:convert';

import 'package:two_dashboard/features/sprints%20&%20tasks/data/models/task/task_model.dart';

CreateAndShowTaskResponseModel createAndShowTaskResponseModelFromJson(
  String str,
) => CreateAndShowTaskResponseModel.fromJson(json.decode(str));

String createAndShowTaskResponseModelToJson(
  CreateAndShowTaskResponseModel data,
) => json.encode(data.toJson());

class CreateAndShowTaskResponseModel {
  final int status;
  final String msg;
  final TaskModel data;

  CreateAndShowTaskResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory CreateAndShowTaskResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateAndShowTaskResponseModel(
        status: json["status"],
        msg: json["msg"],
        data: TaskModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}
