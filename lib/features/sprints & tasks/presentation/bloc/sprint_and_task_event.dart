part of 'sprint_and_task_bloc.dart';

class SprintAndTaskEvent {}

// Sprint Events
class CreateSprintEvent extends SprintAndTaskEvent {
  CreateSprintEvent({
    required this.lable,
    required this.description,
    required this.goal,
    required this.start,
    required this.end,
    required this.projectId,
  });
  final String lable;
  final String description;
  final String goal;
  final String start;
  final String end;
  final int projectId;
}

class UpdateSprintEvent extends SprintAndTaskEvent {
  UpdateSprintEvent({
    required this.sprintId,
    required this.lable,
    required this.description,
    required this.goal,
    required this.start,
    required this.end,
    required this.projectId,
    required this.status,
  });
  final int sprintId;
  final String lable;
  final String description;
  final String goal;
  final String start;
  final String end;
  final int projectId;
  final String status;
}

class DeleteSprintEvent extends SprintAndTaskEvent {
  DeleteSprintEvent({required this.sprintId});
  int sprintId;
}

class StartSprintEvent extends SprintAndTaskEvent {
  final int projectId;
  final int sprintId;

  StartSprintEvent({required this.projectId, required this.sprintId});
}

class CompleteSprintEvent extends SprintAndTaskEvent {
  final int projectId;
  final int sprintId;
  // It takes auto ,null, new, existing
  final String? action;
  // required if the action is new
  final String? newSprintLabel;
  // required if the action is existing
  final int? existingSprintId;

  CompleteSprintEvent({
    required this.projectId,
    required this.sprintId,
    this.action,
    this.newSprintLabel,
    this.existingSprintId,
  });
}

class ShowProjectUnCompleteSprintsEvent extends SprintAndTaskEvent {
  final int projectId;

  ShowProjectUnCompleteSprintsEvent({required this.projectId});
}

class ShowProjectStartedSprintsEvent extends SprintAndTaskEvent {
  final int projectId;

  ShowProjectStartedSprintsEvent({required this.projectId});
}

class ShowProjectPendedSprintsEvent extends SprintAndTaskEvent {
  final int projectId;

  ShowProjectPendedSprintsEvent({required this.projectId});
}

class ShowProjectSprintsEvent extends SprintAndTaskEvent {
  ShowProjectSprintsEvent({required this.projectId});
  int projectId;
}

class ShowSprintDetailsEvent extends SprintAndTaskEvent {
  ShowSprintDetailsEvent({required this.sprintId});
  int sprintId;
}

class CreateBacklogSprintEvent extends SprintAndTaskEvent {
  final int projectId;
  final String label;
  final String description;
  final String goal;
  final String startDate;
  final String endDate;
  final List<int> tasksIds;

  CreateBacklogSprintEvent({
    required this.projectId,
    required this.label,
    required this.description,
    required this.goal,
    required this.startDate,
    required this.endDate,
    required this.tasksIds,
  });
}

// Task Events

class CreateTaskEvent extends SprintAndTaskEvent {
  CreateTaskEvent({
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
}

class UpdateTaskEvent extends SprintAndTaskEvent {
  UpdateTaskEvent({
    required this.taskId,
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
  final int taskId;
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
}

class DeleteTaskEvent extends SprintAndTaskEvent {
  DeleteTaskEvent({required this.taskId});
  int taskId;
}

class ShowProjectTasksEvent extends SprintAndTaskEvent {
  final int projectId;

  ShowProjectTasksEvent({required this.projectId});
}

class ShowSprintTasksEvent extends SprintAndTaskEvent {
  ShowSprintTasksEvent({required this.sprintId});
  int sprintId;
}

class ShowMyProjectTasksEvent extends SprintAndTaskEvent {
  ShowMyProjectTasksEvent({required this.projectId, required this.proirity});
  final int projectId;
  final String proirity;
}

class ShowMySprintTasksEvent extends SprintAndTaskEvent {
  ShowMySprintTasksEvent({
    required this.projectId,
    required this.sprinttId,
    required this.proirity,
    required this.status,
  });
  final int projectId;
  final int sprinttId;
  final String proirity;
  final String status;
}

class ShowProjectBacklogTasksEvent extends SprintAndTaskEvent {
  final int projectId;

  ShowProjectBacklogTasksEvent({required this.projectId});
}

class ShowTaskDetailsEvent extends SprintAndTaskEvent {
  ShowTaskDetailsEvent({required this.taskId});
  int taskId;
}

class ShowMyTasksEvent extends SprintAndTaskEvent {}

class ShowCalendarTasksEvent extends SprintAndTaskEvent {}
