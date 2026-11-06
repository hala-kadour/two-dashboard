import 'package:two_dashboard/features/sprints%20&%20tasks/data/models/task/task_model.dart';

class StatusModel {
  final int id;
  final String name;
  final int order;
  final List<TaskModel> tasks;

  StatusModel({
    required this.id,
    required this.name,
    required this.order,
    required this.tasks,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
    id: json["id"],
    name: json["name"],
    order: json["order"],
    tasks: List<TaskModel>.from(
      json["tasks"].map((x) => TaskModel.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "order": order,
    "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
  };
}
