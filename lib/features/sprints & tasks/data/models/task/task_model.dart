import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/task_entity.dart';

import 'package:two_dashboard/features/profile/data/models/employee_model.dart';

class TaskModel extends TaskEntity {
  final String? sprint;
  final EmployeeModel assignedTo;
  final String status;
  final String priority;
  final String completion;
  final DateTime start;
  final DateTime end;

  TaskModel({
    required super.id,
    required super.sprintId,
    required super.projectId,
    required super.title,
    required super.description,
    required this.assignedTo,
    required this.priority,
    required this.completion,
    required this.status,
    required this.start,
    required this.end,
    required this.sprint,
  }) : super(
         taskPriority: HelperFunctions.getPriorityByName(priority),
         taskStatus: HelperFunctions.getTaskStatusByName(status),
         taskCompletion: double.parse(completion),
         startDate: start,
         endDate: end,
         assignedUser: assignedTo,
         sprintLabel: sprint,
       );

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    sprintId: json["sprint_id"],
    sprint: json["sprint"],
    projectId: json["project_id"],
    status: json["status"],
    assignedTo: EmployeeModel.fromJson(json["assigned_to"]),
    priority: json["priority"],
    completion: json["completion"].toString(),
    start: DateTime.parse(json["start"]),
    end: DateTime.parse(json["end"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "sprint_id": sprintId,
    "sprint": sprint,
    "project_id": projectId,
    "status": status,
    "assigned_to": assignedTo.toJson(),
    "priority": priority,
    "completion": completion,
    "start":
        "${start.year.toString().padLeft(4, '0')}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}",
    "end":
        "${end.year.toString().padLeft(4, '0')}-${end.month.toString().padLeft(2, '0')}-${end.day.toString().padLeft(2, '0')}",
  };
}
