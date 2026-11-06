class DraftEntity {
  final int draftId;
  final String draftPath;
  final int? approvedStatus;
  final int clientId;
  final String clientName;
  final String clientImage;

  DraftEntity({
    required this.draftId,
    required this.draftPath,
    required this.approvedStatus,
    required this.clientId,
    required this.clientName,
    required this.clientImage,
  });
}
