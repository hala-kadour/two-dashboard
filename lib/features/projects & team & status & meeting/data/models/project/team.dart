import 'package:hive/hive.dart';
import 'package:two_dashboard/core/error/exceptions.dart';

part 'team.g.dart';

@HiveType(typeId: 2)
class Team extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<Member> members;

  Team({required this.id, required this.name, required this.members});

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["id"],
    name: json["name"],
    members: List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "members": List<dynamic>.from(members.map((x) => x.toJson())),
  };
}

@HiveType(typeId: 3)
class Member extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String? image;

  @HiveField(5)
  final String role;

  @HiveField(6)
  final bool isManager;

  Member({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.role,
    required this.isManager,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
    role: json["role"] ?? "No Role",
    isManager: json["is_manager"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
    "role": role,
    "is_manager": isManager,
  };
}

// ignore: constant_identifier_names
const String CACHED_TEAM = "CACHED-TEAM";

Future<void> cacheTeamForProject(int projectId, Team team) async {
  final box = Hive.box<Team>(CACHED_TEAM);
  // await box.clear();
  box.put(projectId, team);
}

Future<Team?> getCachedTeamForProject(int projectId) async {
  final box = Hive.box<Team>(CACHED_TEAM);
  if (box.isEmpty) {
    throw EmptyCacheException(message: "No Team Saved");
  }
  return box.get(projectId);
}
