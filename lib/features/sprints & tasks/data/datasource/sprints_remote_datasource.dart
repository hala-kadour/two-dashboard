import 'package:two_dashboard/config/constants/base_uri.dart';
import 'package:two_dashboard/core/api/get_with_token_api.dart';
import 'package:two_dashboard/core/api/post_api_with_token.dart';
import 'package:two_dashboard/core/models/empty_response_model.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/sprint_param.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/data/models/sprint/create_backlog_tasks_sprint_response_model.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/data/models/sprint/show_and_create_sprint_response_model.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/data/models/sprint/show_pending_sprints_tasks.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/data/models/sprint/show_sprints_list_response_model.dart';

abstract class SprintsRemoteDatasource {
  // Sprint Actions 👾 : Create - Update - Delete - Start - Complete
  Future<CreateAndShowSprintResponseModel> createSprint(
    CreateSprintParam param,
  );
  Future<EmptyResponseModel> updateSprint(UpdateSprintParam param);
  Future<EmptyResponseModel> deleteSprint(TokenWithIdParam sprint);
  Future<EmptyResponseModel> startSprint(StartSprintParam param);
  Future<EmptyResponseModel> completeSprint(CompleteSprintParam param);
  // Sprint Lists ( Un Completed Sprints ) ( Started Sprints ) ( Pended Sprints ) ( All Project Sprints )
  Future<ShowSprintsListResponseModel> showProjectUnCompleteSprints(
    TokenWithIdParam project,
  );
  Future<ShowSprintsListResponseModel> showProjectStartedSprints(
    TokenWithIdParam project,
  );
  Future<ShowPendingSprintsTasksResponseModel> showPenedingSprintsTasks(
    TokenWithIdParam project,
  );
  Future<ShowSprintsListResponseModel> showProjectSprints(
    TokenWithIdParam project,
  );
  // Sprint Details
  Future<CreateAndShowSprintResponseModel> showSprintDetails(
    TokenWithIdParam sprint,
  );
  // Create Backlog Sprint
  Future<CreateBacklogTasksSprintResponseModel> createBacklogSprint(
    CreateBacklogSprintParam param,
  );
}

class SprintsRemoteDatasourceImpl extends SprintsRemoteDatasource {
  @override
  Future<CreateAndShowSprintResponseModel> createSprint(
    CreateSprintParam param,
  ) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/create/sprint"),
      token: param.token,
      body: ({
        'label': param.lable,
        'description': param.description,
        'goal': param.goal,
        'start': param.start,
        'end': param.end,
        'project_id': param.projectId,
      }),
      fromJson: createAndShowSprintResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<EmptyResponseModel> deleteSprint(TokenWithIdParam sprint) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/delete/sprint/${sprint.id}"),
      token: sprint.token,
      fromJson: emptyResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<ShowSprintsListResponseModel> showProjectSprints(
    TokenWithIdParam project,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/show/project/sprints/${project.id}"),
      token: project.token,
      fromJson: showSprintsListResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<CreateAndShowSprintResponseModel> showSprintDetails(
    TokenWithIdParam sprint,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/show/sprint/${sprint.id}"),
      token: sprint.token,
      fromJson: createAndShowSprintResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<EmptyResponseModel> updateSprint(UpdateSprintParam param) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/update/sprint"),
      token: param.token,
      body: ({
        'label': param.lable,
        'description': param.description,
        'goal': param.goal,
        'start': param.start,
        'end': param.end,
        'project_id': param.projectId,
        'status': param.status,
        'sprint_id': param.sprintId,
      }),
      fromJson: emptyResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<EmptyResponseModel> completeSprint(CompleteSprintParam param) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/complete/sprint/${param.sprintId}"),
      token: param.token,
      body:
          (param.action == null)
              ? ({'action': "null", 'project_id': param.projectId})
              : (param.action == "new")
              ? ({
                'action': 'new',
                'new_sprint_label': param.newSprintLabel,
                'project_id': param.projectId,
              })
              : (param.action == "auto")
              ? ({'action': 'auto', 'project_id': param.projectId})
              : ({
                'action': 'existing',
                'existing_sprint_id': param.existingSprintId,
                'project_id': param.projectId,
              }),
      fromJson: emptyResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<ShowSprintsListResponseModel> showProjectStartedSprints(
    TokenWithIdParam project,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/show/project/started/sprints/${project.id}"),
      token: project.token,
      fromJson: showSprintsListResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<ShowSprintsListResponseModel> showProjectUnCompleteSprints(
    TokenWithIdParam project,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse(
        "$baseUri/api/show/project/un-complete/sprints/${project.id}",
      ),
      token: project.token,
      fromJson: showSprintsListResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<EmptyResponseModel> startSprint(StartSprintParam param) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/start/sprint"),
      token: param.token,
      body: ({
        'project_id': param.projectId.toString(),
        'sprint_id': param.sprintId.toString(),
      }),
      fromJson: emptyResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<CreateBacklogTasksSprintResponseModel> createBacklogSprint(
    CreateBacklogSprintParam param,
  ) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/create/backlog/tasks/sprint"),
      token: param.token,
      body: ({
        "label": param.label,
        "description": param.description,
        "goal": param.goal,
        "start": param.startDate,
        "end": param.endDate,
        "project_id": param.projectId,
        "tasks_ids": param.tasksIds,
      }),
      fromJson: createBacklogTasksSprintResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<ShowPendingSprintsTasksResponseModel> showPenedingSprintsTasks(
    TokenWithIdParam project,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse(
        "$baseUri/api/show/project/pending-sprints/tasks/${project.id}",
      ),
      token: project.token,
      fromJson: showPendingSprintsTasksResponseModelFromJson,
    );
    return await result.callRequest();
  }
}
