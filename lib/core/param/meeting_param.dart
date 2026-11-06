class CreateMeetingParam {
  final String token;
  final String projectId;
  final String meetingDate;
  final String meetingType;

  CreateMeetingParam({
    required this.token,
    required this.projectId,
    required this.meetingDate,
    required this.meetingType,
  });
}

class UpdateMeetingParam {
  final String token;
  final String projectId;
  final String meetingId;
  final String meetingDate;
  final String meetingType;

  UpdateMeetingParam({
    required this.token,
    required this.projectId,
    required this.meetingId,
    required this.meetingDate,
    required this.meetingType,
  });
}

class DeleteMeetingParam {
  final String token;
  final String projectId;
  final String meetingId;

  DeleteMeetingParam({
    required this.token,
    required this.projectId,
    required this.meetingId,
  });
}
