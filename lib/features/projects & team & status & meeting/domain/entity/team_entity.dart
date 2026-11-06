import 'package:two_dashboard/features/profile/domain/entities/employee_entity.dart';

class TeamEntity {
  final int id;
  final String name;
  final List<EmployeeEntity> membersList;

  TeamEntity({required this.id, required this.name, required this.membersList});
}
