part of 'sprint_and_task_bloc.dart';

class SprintAndTaskState {
  final int? statusNum;
  final String errorMessage;
  // Sprint Actions
  final CasualStatus createSprintStatus;
  final CasualStatus updateSprintStatus;
  final CasualStatus deleteSprintStatus;
  final CasualStatus startSprintStatus;
  final CasualStatus completeSprintStatus;

  // Sprint Lists (Uncomplete, Started, pended ,Casual)
  final List<SprintEntity> projectUnCompleteSprintsList;
  final CasualStatus projectUnCompleteSprintsListStatus;

  final List<SprintEntity> projectStartedSprintsList;
  final CasualStatus projectStartedSprintsListStatus;

  final List<Sprint> projectPendedSprintsList;
  final CasualStatus projectPendedSprintsListStatus;

  final List<SprintEntity> projectSprintsList;
  final CasualStatus projectSprintsListStatus;

  // Sprint Details
  final SprintEntity? sprintEntity;
  final CasualStatus sprintEntityStatus;

  // Task Actions
  final CasualStatus createTaskStatus;
  final CasualStatus updateTaskStatus;
  final CasualStatus deleteTaskStatus;
  final CasualStatus createBacklogTasksSprintStatus;

  // Tasks Lists (All-Tasks ,Project-Tasks, Sprint-Tasks, My-Project-Tasks, My-Sprints-Tasks- Backlog-Tasks)

  final List<TaskEntity> projectTasksList;
  final CasualStatus projectTasksListStatus;

  final List<TaskEntity> sprintTasksList;
  final CasualStatus sprintTasksListStatus;

  final List<TaskEntity> myProjectTasksList;
  final CasualStatus myProjectTasksListStatus;

  final List<TaskEntity> mySprintTasksList;
  final CasualStatus mySprintTasksListStatus;

  final List<TaskModel> backlogTasksList;
  final CasualStatus backlogTasksListStatus;

  final List<TaskEntity> myTasksList;
  final CasualStatus myTasksListStatus;

  final List<TaskEntity> calendarTasksList;
  final CasualStatus calendarTasksListStatus;

  // Tasks Details
  final TaskEntity? taskEntity;
  final CasualStatus taskEntityStatus;

  SprintAndTaskState({
    this.statusNum,
    this.errorMessage = "",
    // Sprint-State
    this.createSprintStatus = CasualStatus.initial,
    this.updateSprintStatus = CasualStatus.initial,
    this.deleteSprintStatus = CasualStatus.initial,
    this.startSprintStatus = CasualStatus.initial,
    this.completeSprintStatus = CasualStatus.initial,
    this.projectUnCompleteSprintsList = const [],
    this.projectUnCompleteSprintsListStatus = CasualStatus.initial,
    this.projectStartedSprintsList = const [],
    this.projectStartedSprintsListStatus = CasualStatus.initial,
    this.projectSprintsList = const [],
    this.projectSprintsListStatus = CasualStatus.initial,
    this.sprintEntity,
    this.sprintEntityStatus = CasualStatus.initial,
    // Task-State
    this.createTaskStatus = CasualStatus.initial,
    this.updateTaskStatus = CasualStatus.initial,
    this.deleteTaskStatus = CasualStatus.initial,
    this.createBacklogTasksSprintStatus = CasualStatus.initial,
    this.projectTasksList = const [],
    this.projectTasksListStatus = CasualStatus.initial,
    this.sprintTasksList = const [],
    this.sprintTasksListStatus = CasualStatus.initial,
    this.myProjectTasksList = const [],
    this.myProjectTasksListStatus = CasualStatus.initial,
    this.mySprintTasksList = const [],
    this.mySprintTasksListStatus = CasualStatus.initial,
    this.backlogTasksList = const [],
    this.backlogTasksListStatus = CasualStatus.initial,
    this.projectPendedSprintsList = const [],
    this.projectPendedSprintsListStatus = CasualStatus.initial,
    this.taskEntity,
    this.taskEntityStatus = CasualStatus.initial,
    this.myTasksList = const [],
    this.myTasksListStatus = CasualStatus.initial,
    this.calendarTasksList = const [],
    this.calendarTasksListStatus = CasualStatus.initial,
  });

  SprintAndTaskState copyWith({
    int? statusNum,
    String? errorMessage,
    CasualStatus? createSprintStatus,
    CasualStatus? updateSprintStatus,
    CasualStatus? deleteSprintStatus,
    CasualStatus? startSprintStatus,
    CasualStatus? completeSprintStatus,
    List<SprintEntity>? projectUnCompleteSprintsList,
    CasualStatus? projectUnCompleteSprintsListStatus,
    List<SprintEntity>? projectStartedSprintsList,
    CasualStatus? projectStartedSprintsListStatus,
    List<Sprint>? projectPendedSprintsList,
    CasualStatus? projectPendedSprintsListStatus,
    List<SprintEntity>? projectSprintsList,
    CasualStatus? projectSprintsListStatus,
    SprintEntity? sprintEntity,
    CasualStatus? sprintEntityStatus,
    CasualStatus? createTaskStatus,
    CasualStatus? updateTaskStatus,
    CasualStatus? deleteTaskStatus,
    CasualStatus? createBacklogTasksSprintStatus,
    List<TaskEntity>? allTasksList,
    CasualStatus? allTasksListStatus,
    List<TaskEntity>? projectTasksList,
    CasualStatus? projectTasksListStatus,
    List<TaskEntity>? sprintTasksList,
    CasualStatus? sprintTasksListStatus,
    List<TaskEntity>? myProjectTasksList,
    CasualStatus? myProjectTasksListStatus,
    List<TaskEntity>? mySprintTasksList,
    CasualStatus? mySprintTasksListStatus,
    List<TaskModel>? backlogTasksList,
    CasualStatus? backlogTasksListStatus,
    List<TaskEntity>? myTasksList,
    CasualStatus? myTasksListStatus,
    List<TaskEntity>? calendarTasksList,
    CasualStatus? calendarTasksListStatus,
    TaskEntity? taskEntity,
    CasualStatus? taskEntityStatus,
  }) {
    return SprintAndTaskState(
      statusNum: statusNum ?? this.statusNum,
      errorMessage: errorMessage ?? this.errorMessage,
      createSprintStatus: createSprintStatus ?? this.createSprintStatus,
      updateSprintStatus: updateSprintStatus ?? this.updateSprintStatus,
      deleteSprintStatus: deleteSprintStatus ?? this.deleteSprintStatus,
      startSprintStatus: startSprintStatus ?? this.startSprintStatus,
      completeSprintStatus: completeSprintStatus ?? this.completeSprintStatus,
      projectUnCompleteSprintsList:
          projectUnCompleteSprintsList ?? this.projectUnCompleteSprintsList,
      projectUnCompleteSprintsListStatus:
          projectUnCompleteSprintsListStatus ??
          this.projectUnCompleteSprintsListStatus,
      projectStartedSprintsList:
          projectStartedSprintsList ?? this.projectStartedSprintsList,
      projectStartedSprintsListStatus:
          projectStartedSprintsListStatus ??
          this.projectStartedSprintsListStatus,
      projectPendedSprintsList:
          projectPendedSprintsList ?? this.projectPendedSprintsList,
      projectPendedSprintsListStatus:
          projectPendedSprintsListStatus ?? this.projectPendedSprintsListStatus,
      projectSprintsList: projectSprintsList ?? this.projectSprintsList,
      projectSprintsListStatus:
          projectSprintsListStatus ?? this.projectSprintsListStatus,
      sprintEntity: sprintEntity ?? this.sprintEntity,
      sprintEntityStatus: sprintEntityStatus ?? this.sprintEntityStatus,
      createTaskStatus: createTaskStatus ?? this.createTaskStatus,
      updateTaskStatus: updateTaskStatus ?? this.updateTaskStatus,
      deleteTaskStatus: deleteTaskStatus ?? this.deleteTaskStatus,
      createBacklogTasksSprintStatus:
          createBacklogTasksSprintStatus ?? this.createBacklogTasksSprintStatus,
      projectTasksList: projectTasksList ?? this.projectTasksList,
      projectTasksListStatus:
          projectTasksListStatus ?? this.projectTasksListStatus,
      sprintTasksList: sprintTasksList ?? this.sprintTasksList,
      sprintTasksListStatus:
          sprintTasksListStatus ?? this.sprintTasksListStatus,
      myProjectTasksList: myProjectTasksList ?? this.myProjectTasksList,
      myProjectTasksListStatus:
          myProjectTasksListStatus ?? this.myProjectTasksListStatus,
      mySprintTasksList: mySprintTasksList ?? this.mySprintTasksList,
      mySprintTasksListStatus:
          mySprintTasksListStatus ?? this.mySprintTasksListStatus,
      backlogTasksList: backlogTasksList ?? this.backlogTasksList,
      backlogTasksListStatus:
          backlogTasksListStatus ?? this.backlogTasksListStatus,
      myTasksList: myTasksList ?? this.myTasksList,
      myTasksListStatus: myTasksListStatus ?? this.myTasksListStatus,
      calendarTasksList: calendarTasksList ?? this.calendarTasksList,
      calendarTasksListStatus:
          calendarTasksListStatus ?? this.calendarTasksListStatus,
      taskEntity: taskEntity ?? this.taskEntity,
      taskEntityStatus: taskEntityStatus ?? this.taskEntityStatus,
    );
  }
}
