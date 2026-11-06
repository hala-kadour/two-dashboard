import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/contract.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/team.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/project_entity.dart';

class ProjectModel extends ProjectEntity {
  final String projectType;
  final List<String> requirementsList;
  final String cooperationType;
  final int private;

  ProjectModel({
    required super.id,
    required this.projectType,
    required super.projectDescription,
    required this.requirementsList,
    required super.document,
    required this.cooperationType,
    required super.contactTime,
    required this.private,
    required super.contract,
    required super.status,
    required super.team,

    // ➕ الحقول الجديدة
    super.start,
    super.end,
    super.review,
  }) : super(
         cType: HelperFunctions.getCooperationTypeByName(cooperationType),
         pType: HelperFunctions.getProjectTypeByName(projectType),
         requirements: requirementsList.join('\n'),
         visibility: HelperFunctions.getVisibilityByNum(private),
       );

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
    id: json["id"],
    projectType: json["project_type"],
    projectDescription: json["project_description"],
    requirementsList: List<String>.from(json["requirements"].map((x) => x)),
    document: json["document"],
    cooperationType: json["cooperation_type"],
    contactTime: json["contact_time"],
    private: json["private"],
    contract:
        json["contract"] != null ? Contract.fromJson(json["contract"]) : null,
    status: json["status"],
    team: json["team"] != null ? Team.fromJson(json["team"]) : null,

    // ➕ الحقول الجديدة
    start: json["start"],
    end: json["end"],
    review: json["review"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "project_type": projectType,
    "project_description": projectDescription,
    "requirements": List<dynamic>.from(requirementsList.map((x) => x)),
    "document": document,
    "cooperation_type": cooperationType,
    "contact_time": contactTime,
    "private": private,
    "contract": contract?.toJson(),
    "status": status,
    "team": team?.toJson(),

    // ➕ الحقول الجديدة
    "start": start,
    "end": end,
    "review": review,
  };
}
