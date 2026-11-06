import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/contract.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/team.dart';

class ProjectEntity {
  final int id;
  final String fullName;
  final String companyName;
  final String email;
  final String phone;
  final ProjectType pType;
  final String projectDescription;
  final String cost;
  final String duration;
  final String requirements;
  final String document;
  final CooperationType cType;
  final String contactTime;
  final ProjectVisibility visibility;
  final String status;
  final Contract? contract;
  final Team? team;

  // ➕ الحقول الجديدة
  final String? start;
  final String? end;
  final int? review;

  ProjectEntity({
    required this.id,
    this.fullName = '',
    this.companyName = '',
    this.email = '',
    this.phone = '',
    required this.pType,
    this.projectDescription = '',
    this.cost = '',
    this.duration = '',
    this.requirements = '',
    this.document = '',
    required this.cType,
    required this.contactTime,
    required this.visibility,
    required this.status,
    this.contract,
    this.team,
    this.start,
    this.end,
    this.review,
  });
}
