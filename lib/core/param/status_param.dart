class CreateStatusParam {
  final String token;
  final int projectId;
  final String name;

  CreateStatusParam({
    required this.projectId,
    required this.name,
    required this.token,
  });
}

class DeleteStatusParam {
  final String token;
  final int projectId;
  final int statusId;

  DeleteStatusParam({
    required this.token,
    required this.projectId,
    required this.statusId,
  });
}

class UpdateStatusOrderParam {
  final String token;
  final int projectId;
  final int statusId;
  final int newOrder;

  UpdateStatusOrderParam({
    required this.token,
    required this.projectId,
    required this.statusId,
    required this.newOrder,
  });
}

class ShowProjectBoardParam {
  final String token;
  final int projectId;
  final List<int> sprintsIdList;

  ShowProjectBoardParam({
    required this.token,
    required this.projectId,
    required this.sprintsIdList,
  });
}
