import 'package:two_dashboard/config/constants/base_uri.dart';
import 'package:two_dashboard/core/api/get_with_token_api.dart';
import 'package:two_dashboard/core/api/post_api_with_token.dart';
import 'package:two_dashboard/core/models/empty_response_model.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/task_param.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/data/models/task/create_and_show_task_response_model.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/data/models/task/show_task_list_response_model.dart';

abstract class TaskRemoteDatasource {
  //Task Actions : 🧠 Create - Update - Delete
  Future<CreateAndShowTaskResponseModel> createTask(CreateTaskParam param);
  Future<EmptyResponseModel> updateTask(UpdateTaskParam param);
  Future<EmptyResponseModel> deleteTask(TokenWithIdParam task);
  Future<CreateAndShowTaskResponseModel> showTaskDetails(TokenWithIdParam task);
  // Tasks Lists (My-Tasks ,Project-Tasks, Sprint-Tasks, My-Project-Tasks, My-Sprints-Tasks- Backlog-Tasks)
  Future<ShowTaskListResponseModel> showMyTasksList(String token);
  Future<ShowTaskListResponseModel> showProjectTasks(TokenWithIdParam project);
  Future<ShowTaskListResponseModel> showSprintTasks(TokenWithIdParam sprint);
  Future<ShowTaskListResponseModel> showMyProjectTasks(
    ShowMyProjectTasksParam param,
  );
  Future<ShowTaskListResponseModel> showMySprintTasks(
    ShowMySprintTasksParam param,
  );
  Future<ShowTaskListResponseModel> showProjectBackLogTasks(
    TokenWithIdParam project,
  );
}

class TaskRemoteDatasourceImpl extends TaskRemoteDatasource {
  @override
  Future<CreateAndShowTaskResponseModel> createTask(
    CreateTaskParam param,
  ) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/create/task"),
      token: param.token,
      body: ({
        'title': param.title,
        'description': param.description,
        'project_id': param.projectId.toString(),
        'sprint_id': param.sprintId.toString(),
        'status_id': param.statusId.toString(),
        'user_id': param.userId.toString(),
        'priority': param.priority,
        'completion': param.completion.toString(),
        'start': param.startDate,
        'end': param.endDate,
      }),
      fromJson: createAndShowTaskResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<EmptyResponseModel> deleteTask(TokenWithIdParam task) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/delete/task/${task.id}"),
      token: task.token,
      fromJson: emptyResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<ShowTaskListResponseModel> showMySprintTasks(
    ShowMySprintTasksParam param,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse(
        "$baseUri/api/show/project/employee/tasks?filter[sprint_id]=${param.sprinttId}",
        //"$baseUri/api/show/project/employee/tasks?filter[sprint_id]=${param.sprinttId}&filter[priority]=${param.proirity}&filter[status_id]=${param.status}",
      ),
      token: param.token,
      fromJson: showTaskListResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<ShowTaskListResponseModel> showMyProjectTasks(
    ShowMyProjectTasksParam param,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse(
        "$baseUri/api/show/employee/tasks?filter[project_id]=${param.projectId}&filter[priority]=${param.proirity}",
      ),
      token: param.token,
      fromJson: showTaskListResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<ShowTaskListResponseModel> showProjectTasks(
    TokenWithIdParam project,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/show/project/tasks/${project.id}"),
      token: project.token,
      fromJson: showTaskListResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<ShowTaskListResponseModel> showSprintTasks(
    TokenWithIdParam sprint,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/show/sprint/tasks/${sprint.id}"),
      token: sprint.token,
      fromJson: showTaskListResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<CreateAndShowTaskResponseModel> showTaskDetails(
    TokenWithIdParam task,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/show/task/${task.id}"),
      token: task.token,
      fromJson: createAndShowTaskResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<EmptyResponseModel> updateTask(UpdateTaskParam param) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/update/task"),
      token: param.token,
      body: ({
        'title': param.title,
        'description': param.description,
        'project_id': param.projectId.toString(),
        'sprint_id': param.sprintId.toString(),
        'status_id': param.statusId.toString(),
        'user_id': param.userId.toString(),
        'priority': param.priority,
        'completion': param.completion.toString(),
        'start': param.startDate,
        'end': param.endDate,
        'task_id': param.taskId,
      }),
      fromJson: emptyResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<ShowTaskListResponseModel> showProjectBackLogTasks(
    TokenWithIdParam project,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/show/project/backlog/tasks/${project.id}"),
      token: project.token,
      fromJson: showTaskListResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<ShowTaskListResponseModel> showMyTasksList(String token) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/show/employee/tasks"),
      token: token,
      fromJson: showTaskListResponseModelFromJson,
    );
    return await result.callRequest();
  }
}
