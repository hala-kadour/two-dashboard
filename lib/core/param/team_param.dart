class AddTeamParam {
  String token;
  int projectId;
  int teamId;
  AddTeamParam({
    required this.token,
    required this.projectId,
    required this.teamId,
  });
}

class AddTeamMembersParam {
  final String token;
  final int teamId;
  final List<int> memebersIdList;

  AddTeamMembersParam({
    required this.token,
    required this.teamId,
    required this.memebersIdList,
  });
}

class CreateTeamParam {
  final String token;
  final String name;
  final int mgrId;
  final List<int> memebersIdList;

  CreateTeamParam({
    required this.token,
    required this.name,
    required this.mgrId,
    required this.memebersIdList,
  });
}
