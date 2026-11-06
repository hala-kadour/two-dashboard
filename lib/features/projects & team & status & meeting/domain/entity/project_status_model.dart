import 'package:hive/hive.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/status/status_model.dart';

part 'project_status_model.g.dart';

// ignore: constant_identifier_names
const String CACHED_STATUS = "CACHED-STATUS";

@HiveType(typeId: 0)
class ProjectStatus extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int projectId;

  ProjectStatus({
    required this.id,
    required this.name,
    required this.projectId,
  });
}

Future<void> cacheStatuses(List<ProjectStatus> statuses) async {
  final box = Hive.box<ProjectStatus>(CACHED_STATUS);
  await box.clear(); // لو بدك تعيدي التخزين من جديد
  for (var status in statuses) {
    await box.put('${status.projectId}-${status.id}', status);
  }
}

List<ProjectStatus> getcachedStatusesForProject(int projectId) {
  final box = Hive.box<ProjectStatus>(CACHED_STATUS);
  return box.values.where((s) => s.projectId == projectId).toList();
}

// حتى اقدر احول بين الموديلات
ProjectStatus mapStatusModelToProjectStatus(
  StatusModel statusModel,
  int projectId,
) {
  return ProjectStatus(
    id: statusModel.id,
    name: statusModel.name,
    projectId: projectId,
  );
}
