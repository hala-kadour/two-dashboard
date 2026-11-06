class Contract {
  final int id;
  final String? contract;
  final int projectId;
  final int contractManagerStatus;
  final int projectManagerStatus;
  final String? clientSign;
  final int status;
  final String? clientEditRequest;
  final int needEdit;
  final int adminSign;
  final DateTime createdAt;
  final DateTime updatedAt;

  Contract({
    required this.id,
    required this.contract,
    required this.projectId,
    required this.contractManagerStatus,
    required this.projectManagerStatus,
    required this.clientSign,
    required this.status,
    required this.clientEditRequest,
    required this.needEdit,
    required this.adminSign,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
    id: json["id"],
    contract: json["contract"],
    projectId: json["project_id"],
    contractManagerStatus: json["contract_manager_status"],
    projectManagerStatus: json["project_manager_status"],
    clientSign: json["client_sign"],
    status: json["status"],
    clientEditRequest: json["client_edit_request"],
    needEdit: json["need_edit"],
    adminSign: json["admin_sign"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "contract": contract,
    "project_id": projectId,
    "contract_manager_status": contractManagerStatus,
    "project_manager_status": projectManagerStatus,
    "client_sign": clientSign,
    "status": status,
    "client_edit_request": clientEditRequest,
    "need_edit": needEdit,
    "admin_sign": adminSign,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
