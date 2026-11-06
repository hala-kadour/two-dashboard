class ContractEntity {
  final int contractId;
  final String contractPath;
  final String clientID;
  final String clientName;
  final String? clientImage;
  final String? clientSign;

  ContractEntity({
    required this.contractId,
    required this.contractPath,
    required this.clientID,
    required this.clientName,
    this.clientImage,
    required this.clientSign,
  });
}
