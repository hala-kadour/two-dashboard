// import 'package:hive/hive.dart';
// import 'package:two_dashboard/core/error/exceptions.dart';
// import 'package:two_dashboard/features/projects%20&%20team%20&%20status/data/models/project/team.dart';

// abstract class TeamLocaleDataRource {
//   Future<void> cacheTeamForProject(int projectId, Team team);
//   Future<Team?> getCachedTeamForProject(int projectId);
// }

// class TeamLocaleDataSourceImpl extends TeamLocaleDataRource {
//   @override
//   Future<void> cacheTeamForProject(int projectId, Team team) async {
//     final box = Hive.box<Team>(CACHED_TEAM);
//     await box.clear();
//     box.put(projectId, team);
//   }

//   @override
//   Future<Team?> getCachedTeamForProject(int projectId) async {
//     final box = Hive.box<Team>(CACHED_TEAM);
//     if (box.isEmpty) {
//       throw EmptyCacheException(message: "No Team Saved");
//     }
//     return box.get(projectId);
//   }
// }
