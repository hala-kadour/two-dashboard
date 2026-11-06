import 'dart:convert';

import 'package:two_dashboard/features/sprints%20&%20tasks/data/models/task/task_model.dart';

ShowProjectBoardResponseModel showProjectBoardResponseModelFromJson(
  String str,
) => ShowProjectBoardResponseModel.fromJson(json.decode(str));

String showProjectBoardResponseModelToJson(
  ShowProjectBoardResponseModel data,
) => json.encode(data.toJson());

class ShowProjectBoardResponseModel {
  final int status;
  final String msg;
  final List<StatusBoardModel> data;

  ShowProjectBoardResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory ShowProjectBoardResponseModel.fromJson(Map<String, dynamic> json) =>
      ShowProjectBoardResponseModel(
        status: json["status"],
        msg: json["msg"],
        data: List<StatusBoardModel>.from(
          json["data"].map((x) => StatusBoardModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class StatusBoardModel {
  final int id;
  final String name;
  final int order;
  final dynamic incompleteTasksBySprint;
  final List<TaskModel> tasks;

  StatusBoardModel({
    required this.id,
    required this.name,
    required this.order,
    required this.incompleteTasksBySprint,
    required this.tasks,
  });

  factory StatusBoardModel.fromJson(Map<String, dynamic> json) =>
      StatusBoardModel(
        id: json["id"],
        name: json["name"],
        order: json["order"],
        incompleteTasksBySprint: json["incomplete_tasks_by_sprint"],
        tasks: List<TaskModel>.from(
          json["tasks"].map((x) => TaskModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "order": order,
    "incomplete_tasks_by_sprint": incompleteTasksBySprint,
    "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
  };
}

class IncompleteTasksBySprintClass {
  final int the1;

  IncompleteTasksBySprintClass({required this.the1});

  factory IncompleteTasksBySprintClass.fromJson(Map<String, dynamic> json) =>
      IncompleteTasksBySprintClass(the1: json["1"]);

  Map<String, dynamic> toJson() => {"1": the1};
}
