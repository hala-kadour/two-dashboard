import 'package:hive/hive.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/sprint_entity.dart';

part 'project_sprint.g.dart';

// ignore: constant_identifier_names
const String CACHED_SPRINTS = "CACHED-SPRINTS";

@HiveType(typeId: 4)
class ProjectSprint extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int projectId;

  ProjectSprint({
    required this.id,
    required this.name,
    required this.projectId,
  });
}

Future<void> cacheProjectSprints(List<ProjectSprint> sprints) async {
  final box = Hive.box<ProjectSprint>(CACHED_SPRINTS);
  await box.clear();
  for (var sprint in sprints) {
    await box.put('${sprint.projectId}-${sprint.id}', sprint);
  }
}

List<ProjectSprint> getCachedSprintForProject(int projectId) {
  final box = Hive.box<ProjectSprint>(CACHED_SPRINTS);
  return box.values.where((s) => s.projectId == projectId).toList();
}

ProjectSprint mapSprintEntityToProjectSprint(
  SprintEntity sprintEnity,
  int projectId,
) {
  return ProjectSprint(
    id: sprintEnity.id,
    name: sprintEnity.label,
    projectId: projectId,
  );
}
