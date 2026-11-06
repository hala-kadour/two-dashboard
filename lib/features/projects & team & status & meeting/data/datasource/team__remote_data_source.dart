import 'package:two_dashboard/config/constants/base_uri.dart';
import 'package:two_dashboard/core/api/get_api.dart';
import 'package:two_dashboard/core/api/post_api_with_token.dart';
import 'package:two_dashboard/core/models/empty_response_model.dart';
import 'package:two_dashboard/core/param/team_param.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/team/create_team_add_members_response_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/team/show_team_reponse_model.dart';

abstract class TeamRemoteDataSource {
  Future<CreateTeamResponseModel> createTeam(CreateTeamParam param);
  Future<CreateTeamResponseModel> addMembers(AddTeamMembersParam param);
  Future<ShowTeamResponseModel> showTeams();
  Future<EmptyResponseModel> addTeam(AddTeamParam param);
}

class TeamRemoteDataSourceImpl extends TeamRemoteDataSource {
  @override
  Future<CreateTeamResponseModel> addMembers(AddTeamMembersParam param) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/add/members"),
      token: param.token,
      body: ({"team_id": param.teamId, "team_members": param.memebersIdList}),
      fromJson: createTeamResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<CreateTeamResponseModel> createTeam(CreateTeamParam param) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/create/team"),
      token: param.token,
      body: ({
        "name": param.name,
        "team_manager": param.mgrId,
        "team_members": param.memebersIdList,
      }),
      fromJson: createTeamResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<ShowTeamResponseModel> showTeams() async {
    final result = GetApi(
      uri: Uri.parse("$baseUri/api/show/teams"),
      fromJson: showTeamResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<EmptyResponseModel> addTeam(AddTeamParam param) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/specify/project/team"),
      token: param.token,
      body: ({"project_id": param.projectId, "team_id": param.teamId}),
      fromJson: emptyResponseModelFromJson,
    );
    return await result.call();
  }
}
