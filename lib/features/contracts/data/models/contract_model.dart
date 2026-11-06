class ContractModel {
  final int id;
  final String contract;
  final int? contractManagerStatus;
  final int? projectManagerStatus;
  final int? status;
  final dynamic clientEditRequest;
  final int? needEdit;
  final int? adminSign;
  final Project project;

  ContractModel({
    required this.id,
    required this.contract,
    required this.contractManagerStatus,
    required this.projectManagerStatus,
    required this.status,
    required this.clientEditRequest,
    required this.needEdit,
    required this.adminSign,
    required this.project,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) => ContractModel(
    id: json["id"],
    contract: json["contract"],
    contractManagerStatus: json["contract_manager_status"],
    projectManagerStatus: json["project_manager_status"],
    status: json["status"] ?? 0,
    clientEditRequest: json["client_edit_request"],
    needEdit: json["need_edit"],
    adminSign: json["admin_sign"],
    project: Project.fromJson(json["project"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "contract": contract,
    "contract_manager_status": contractManagerStatus,
    "project_manager_status": projectManagerStatus,
    "status": status,
    "client_edit_request": clientEditRequest,
    "need_edit": needEdit,
    "admin_sign": adminSign,
    "project": project.toJson(),
  };
}

class Project {
  final int id;
  final String projectType;
  final String projectDescription;
  final List<String> requirementsList;
  final String? document;
  final String cooperationType;
  final String contactTime;
  final int clientId;
  final int teamId;
  final String status;
  final int private;
  final DateTime createdAt;
  final DateTime updatedAt;

  Project({
    required this.id,
    required this.projectType,
    required this.projectDescription,
    required this.requirementsList,
    required this.document,
    required this.cooperationType,
    required this.contactTime,
    required this.clientId,
    required this.teamId,
    required this.status,
    required this.private,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json["id"],
    projectType: json["project_type"],
    projectDescription: json["project_description"],
    requirementsList: List<String>.from(json["requirements"].map((x) => x)),
    document: json["document"],
    cooperationType: json["cooperation_type"],
    contactTime: json["contact_time"],
    clientId: json["client_id"],
    teamId: json["team_id"],
    status: json["status"],
    private: json["private"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "project_type": projectType,
    "project_description": projectDescription,
    "requirements": List<dynamic>.from(requirementsList.map((x) => x)),
    "document": document,
    "cooperation_type": cooperationType,
    "contact_time": contactTime,
    "client_id": clientId,
    "team_id": teamId,
    "status": status,
    "private": private,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
