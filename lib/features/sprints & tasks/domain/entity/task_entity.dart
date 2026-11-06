import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/features/profile/domain/entities/employee_entity.dart';

class TaskEntity {
  final int id;
  final int? sprintId;
  final String? sprintLabel;
  final int projectId;
  final String title;
  final String description;
  final TaskStatus taskStatus;
  final EmployeeEntity assignedUser;
  final TaskPriority taskPriority;
  final double taskCompletion;
  final DateTime startDate;
  final DateTime endDate;

  TaskEntity({
    required this.id,
    required this.sprintId,
    required this.sprintLabel,
    required this.projectId,
    required this.title,
    required this.description,
    required this.taskStatus,
    required this.assignedUser,
    required this.taskPriority,
    required this.taskCompletion,
    required this.startDate,
    required this.endDate,
  });
}
