import 'dart:convert';

import 'package:two_dashboard/features/sprints%20&%20tasks/data/models/sprint/sprint.dart';

ShowPendingSprintsTasksResponseModel
showPendingSprintsTasksResponseModelFromJson(String str) =>
    ShowPendingSprintsTasksResponseModel.fromJson(json.decode(str));

String showPendingSprintsTasksResponseModelToJson(
  ShowPendingSprintsTasksResponseModel data,
) => json.encode(data.toJson());

class ShowPendingSprintsTasksResponseModel {
  final int status;
  final String msg;
  final List<Sprint> data;

  ShowPendingSprintsTasksResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory ShowPendingSprintsTasksResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => ShowPendingSprintsTasksResponseModel(
    status: json["status"],
    msg: json["msg"],
    data: List<Sprint>.from(json["data"].map((x) => Sprint.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
