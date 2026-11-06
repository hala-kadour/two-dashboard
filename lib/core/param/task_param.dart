import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/team.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/task_entity.dart';

class CreateTaskParam {
  final String token;
  final String title;
  final String description;
  final int projectId;
  final int sprintId;
  final int statusId;
  final int userId;
  final String priority;
  final double completion;
  final String startDate;
  final String endDate;

  CreateTaskParam({
    required this.token,
    required this.title,
    required this.description,
    required this.projectId,
    required this.sprintId,
    required this.statusId,
    required this.userId,
    required this.priority,
    required this.completion,
    required this.startDate,
    required this.endDate,
  });
}

class UpdateTaskParam {
  final int taskId;
  final String token;
  final String title;
  final String description;
  final int projectId;
  final int sprintId;
  final int statusId;
  final int userId;
  final String priority;
  final double completion;
  final String startDate;
  final String endDate;

  UpdateTaskParam({
    required this.taskId,
    required this.token,
    required this.title,
    required this.description,
    required this.projectId,
    required this.sprintId,
    required this.statusId,
    required this.userId,
    required this.priority,
    required this.completion,
    required this.startDate,
    required this.endDate,
  });
}

class ShowMyProjectTasksParam {
  final String token;
  final int projectId;
  final String proirity;

  ShowMyProjectTasksParam({
    required this.token,
    required this.projectId,
    required this.proirity,
  });
}

class ShowMySprintTasksParam {
  final String token;
  final int projectId;
  final int sprinttId;
  final String proirity;
  final String status;

  ShowMySprintTasksParam({
    required this.token,
    required this.projectId,
    required this.sprinttId,
    required this.proirity,
    required this.status,
  });
}

class UpdateTaskPageParam {
  final TaskEntity taskEntity;
  final Team projectTeam;

  UpdateTaskPageParam({required this.taskEntity, required this.projectTeam});
}
