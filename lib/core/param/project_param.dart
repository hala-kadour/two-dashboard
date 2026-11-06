// ignore_for_file: public_member_api_docs, sort_constructors_first
class UpdateProjectParam {
  final String token;
  final int projectId;
  final String projectType;
  final String projectDescription;
  final String requirements;
  final String? document;
  final String cooperationType;
  final String contactTime;
  final int visibility;
  UpdateProjectParam({
    required this.token,
    required this.projectId,
    required this.projectType,
    required this.projectDescription,
    required this.requirements,
    this.document,
    required this.cooperationType,
    required this.contactTime,
    required this.visibility,
  });
}

class RejectProjectParam {
  String token;
  int projectId;
  String message;
  RejectProjectParam({
    required this.token,
    required this.projectId,
    required this.message,
  });
}

class SentEditRequestParam {
  String token;
  int projectId;
  String message;
  SentEditRequestParam({
    required this.token,
    required this.projectId,
    required this.message,
  });
}

class UpdateProjectDateParam {
  final String token;
  final String projectId;
  final String startDate;
  final String endDate;

  UpdateProjectDateParam({
    required this.token,
    required this.projectId,
    required this.startDate,
    required this.endDate,
  });
}
