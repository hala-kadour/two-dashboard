part of 'contract_bloc.dart';

class ContractEvent {}

class AddDraftEvent extends ContractEvent {
  final String pdfFilePath;
  final int projectId;

  AddDraftEvent({required this.pdfFilePath, required this.projectId});
}

class ShowContractsEvent extends ContractEvent {
  final int stateFilter;

  ShowContractsEvent({required this.stateFilter});
}

// For The Contract Manager

class ContractManagerShowContractsEvent extends ContractEvent {}

class ContractManagerUpdateContractEvent extends ContractEvent {
  final String pdfFilePath;
  final String contractId;

  ContractManagerUpdateContractEvent({
    required this.pdfFilePath,
    required this.contractId,
  });
}

class ContractManagerApproveContractEvent extends ContractEvent {
  final int contractId;
  final int projectId;

  ContractManagerApproveContractEvent({
    required this.contractId,
    required this.projectId,
  });
}

// For The Project Manager
class ProjectManagerUpdateContractEvent extends ContractEvent {
  final String pdfFilePath;
  final String contractId;
  final String projectId;

  ProjectManagerUpdateContractEvent({
    required this.pdfFilePath,
    required this.contractId,
    required this.projectId,
  });
}

class ProjectManagerApproveContractEvent extends ContractEvent {
  final int contractId;
  final int projectId;

  ProjectManagerApproveContractEvent({
    required this.contractId,
    required this.projectId,
  });
}

// For The Admin

class AdminShowContractsEvent extends ContractEvent {
  final int adminSignFilter;

  AdminShowContractsEvent({required this.adminSignFilter});
}

class AdminSignContractEvent extends ContractEvent {
  final String signature;
  final String contractId;

  AdminSignContractEvent({required this.signature, required this.contractId});
}

class AdminPermitDevelopingProjectEvent extends ContractEvent {
  final int projectId;

  AdminPermitDevelopingProjectEvent({required this.projectId});
}
