import 'package:two_dashboard/config/constants/base_uri.dart';
import 'package:two_dashboard/core/api/get_with_token_api.dart';
import 'package:two_dashboard/core/api/post_api_with_token.dart';
import 'package:two_dashboard/core/models/empty_response_model.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/status_param.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/status/create_project_status_response_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/status/show_project_board_response_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/status/show_status_list_response_model.dart';

abstract class StatusRemoteDataSource {
  // Status Actions 💚 : Create - Update - Delete
  Future<CreateStatusResponseModel> createStatus(CreateStatusParam param);
  Future<EmptyResponseModel> deleteStatus(DeleteStatusParam param);
  Future<EmptyResponseModel> updateStatusOrder(UpdateStatusOrderParam param);
  // Status List
  Future<ShowStatusListResponseModel> showStatus(TokenWithIdParam project);
  // Status List with Tasks List Inside - Project Board 🔥
  Future<ShowProjectBoardResponseModel> showProjectBoard(
    ShowProjectBoardParam param,
  );
}

class StatusRemoteDataSourceImpl extends StatusRemoteDataSource {
  @override
  Future<CreateStatusResponseModel> createStatus(
    CreateStatusParam param,
  ) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/create/status"),
      token: param.token,
      body: ({'project_id': param.projectId, 'name': param.name}),
      fromJson: createStatusResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<EmptyResponseModel> deleteStatus(DeleteStatusParam param) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/delete/status"),
      token: param.token,
      body: ({'project_id': param.projectId, 'status_id': param.statusId}),
      fromJson: emptyResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<ShowStatusListResponseModel> showStatus(
    TokenWithIdParam project,
  ) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/show/project/status"),
      token: project.token,
      body: ({'project_id': project.id}),
      fromJson: showStatusListResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<EmptyResponseModel> updateStatusOrder(
    UpdateStatusOrderParam param,
  ) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/update/status"),
      token: param.token,
      body: ({
        'status_id': param.statusId,
        'new_order': param.newOrder,
        'project_id': param.projectId,
      }),
      fromJson: emptyResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<ShowProjectBoardResponseModel> showProjectBoard(
    ShowProjectBoardParam param,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse(
        "$baseUri/api/project/${param.projectId}/board?filter[sprint_id]=${param.sprintsIdList}",
      ),
      body: ({'project_id': param.projectId}),
      token: param.token,
      fromJson: showProjectBoardResponseModelFromJson,
    );
    return await result.callRequest();
  }
}
