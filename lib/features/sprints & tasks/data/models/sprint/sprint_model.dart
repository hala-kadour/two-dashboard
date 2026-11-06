import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/sprint_entity.dart';

class SprintModel extends SprintEntity {
  final String status;

  SprintModel({
    required super.id,
    required super.label,
    required super.description,
    required super.goal,
    required super.start,
    required super.end,
    required super.projectId,
    required super.incompleteTasksCount,
    required this.status,
  }) : super(sprintStatus: status);

  factory SprintModel.fromJson(Map<String, dynamic> json) => SprintModel(
    id: json["id"],
    label: json["label"],
    description: json["description"],
    goal: json["goal"],
    start: DateTime.parse(json["start"]),
    end: DateTime.parse(json["end"]),
    status: json["status"],
    projectId: json["project_id"],
    incompleteTasksCount: json["incomplete_tasks_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "description": description,
    "goal": goal,
    "start": start.toIso8601String(),
    "end": end.toIso8601String(),
    "status": status,
    "project_id": projectId,
    "incomplete_tasks_count": incompleteTasksCount,
  };
}
