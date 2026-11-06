class ProjectAssignRequestModel {
  final int id;
  final String projectType;
  final String projectDescription;
  final List<String> requirements;
  final String document;
  final String cooperationType;
  final String contactTime;
  final int private;
  final dynamic contract;
  final String status;

  ProjectAssignRequestModel({
    required this.id,
    required this.projectType,
    required this.projectDescription,
    required this.requirements,
    required this.document,
    required this.cooperationType,
    required this.contactTime,
    required this.private,
    required this.contract,
    required this.status,
  });

  factory ProjectAssignRequestModel.fromJson(Map<String, dynamic> json) =>
      ProjectAssignRequestModel(
        id: json["id"],
        projectType: json["project_type"],
        projectDescription: json["project_description"],
        requirements: List<String>.from(json["requirements"].map((x) => x)),
        document: json["document"],
        cooperationType: json["cooperation_type"],
        contactTime: json["contact_time"],
        private: json["private"],
        contract: json["contract"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "project_type": projectType,
    "project_description": projectDescription,
    "requirements": List<dynamic>.from(requirements.map((x) => x)),
    "document": document,
    "cooperation_type": cooperationType,
    "contact_time": contactTime,
    "private": private,
    "contract": contract,
    "status": status,
  };
}
