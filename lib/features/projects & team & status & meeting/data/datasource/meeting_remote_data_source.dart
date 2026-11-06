import 'package:two_dashboard/config/constants/base_uri.dart';
import 'package:two_dashboard/core/api/get_api.dart';
import 'package:two_dashboard/core/api/post_api_with_token.dart';
import 'package:two_dashboard/core/models/empty_response_model.dart';
import 'package:two_dashboard/core/param/meeting_param.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/meeting/show_project_meeting_list_reponse_model.dart';

abstract class MeetingRemoteDataSource {
  Future<EmptyResponseModel> createMeeting(CreateMeetingParam param);
  Future<ShowProjectMeetingListResponseModel> showProjectMeetingList(
    int projectId,
  );
  Future<EmptyResponseModel> updateMeeting(UpdateMeetingParam param);
  Future<EmptyResponseModel> deleteMeeting(DeleteMeetingParam param);
}

class MeetingRemoteDataSourceImpl extends MeetingRemoteDataSource {
  @override
  Future<EmptyResponseModel> createMeeting(CreateMeetingParam param) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/create/meeting"),
      token: param.token,
      body: ({
        "date": param.meetingDate,
        "meeting_type": param.meetingType,
        "project_id": param.projectId,
      }),
      fromJson: emptyResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<EmptyResponseModel> deleteMeeting(DeleteMeetingParam param) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/delete/meeting"),
      token: param.token,
      body: ({"meeting_id": param.meetingId, "project_id": param.projectId}),
      fromJson: emptyResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<ShowProjectMeetingListResponseModel> showProjectMeetingList(
    int projectId,
  ) async {
    final result = GetApi(
      uri: Uri.parse("$baseUri/api/show/project/meetings/$projectId"),
      fromJson: showProjectMeetingListResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<EmptyResponseModel> updateMeeting(UpdateMeetingParam param) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/update/meeting"),
      token: param.token,
      body: ({
        "date": param.meetingDate,
        "meeting_type": param.meetingType,
        "meeting_id": param.meetingId,
        "project_id": param.projectId,
      }),
      fromJson: emptyResponseModelFromJson,
    );
    return await result.call();
  }
}
