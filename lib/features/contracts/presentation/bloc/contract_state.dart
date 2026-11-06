// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contract_bloc.dart';

class ContractState {
  String errorMessage;
  CasualStatus addDraftStatus;
  List<ContractModel> contrcatList;
  CasualStatus contrcatListStatus;
  // For The Contract Manager -- CM
  List<ContractModel> contrcatListForCM;
  CasualStatus contrcatListForCMStatus;
  CasualStatus updateContractByCMStatus;
  CasualStatus approveContractByCMStatus;
  // For The Project Manager -- PM
  CasualStatus updateContractByPMStatus;
  CasualStatus approveContractByPMStatus;
  // For The Admin -- AD
  List<ContractModel> contrcatListForAD;
  CasualStatus contrcatListForADStatus;
  CasualStatus adminSignContractStatus;
  CasualStatus adminPermitDevelopingProjectStatus;

  ContractState({
    this.errorMessage = "",
    this.addDraftStatus = CasualStatus.initial,
    this.contrcatList = const [],
    this.contrcatListStatus = CasualStatus.initial,
    this.contrcatListForCM = const [],
    this.contrcatListForCMStatus = CasualStatus.initial,
    this.updateContractByCMStatus = CasualStatus.initial,
    this.approveContractByCMStatus = CasualStatus.initial,
    this.updateContractByPMStatus = CasualStatus.initial,
    this.approveContractByPMStatus = CasualStatus.initial,
    this.contrcatListForAD = const [],
    this.contrcatListForADStatus = CasualStatus.initial,
    this.adminSignContractStatus = CasualStatus.initial,
    this.adminPermitDevelopingProjectStatus = CasualStatus.initial,
  });

  ContractState copyWith({
    String? errorMessage,
    CasualStatus? addDraftStatus,
    List<ContractModel>? contrcatList,
    CasualStatus? contrcatListStatus,
    List<ContractModel>? contrcatListForCM,
    CasualStatus? contrcatListForCMStatus,
    CasualStatus? updateContractByCMStatus,
    CasualStatus? approveContractByCMStatus,
    CasualStatus? updateContractByPMStatus,
    CasualStatus? approveContractByPMStatus,
    List<ContractModel>? contrcatListForAD,
    CasualStatus? contrcatListForADStatus,
    CasualStatus? adminSignContractStatus,
    CasualStatus? adminPermitDevelopingProjectStatus,
  }) {
    return ContractState(
      errorMessage: errorMessage ?? this.errorMessage,
      addDraftStatus: addDraftStatus ?? this.addDraftStatus,
      contrcatList: contrcatList ?? this.contrcatList,
      contrcatListStatus: contrcatListStatus ?? this.contrcatListStatus,
      contrcatListForCM: contrcatListForCM ?? this.contrcatListForCM,
      contrcatListForCMStatus:
          contrcatListForCMStatus ?? this.contrcatListForCMStatus,
      updateContractByCMStatus:
          updateContractByCMStatus ?? this.updateContractByCMStatus,
      approveContractByCMStatus:
          approveContractByCMStatus ?? this.approveContractByCMStatus,
      updateContractByPMStatus:
          updateContractByPMStatus ?? this.updateContractByPMStatus,
      approveContractByPMStatus:
          approveContractByPMStatus ?? this.approveContractByPMStatus,
      contrcatListForAD: contrcatListForAD ?? this.contrcatListForAD,
      contrcatListForADStatus:
          contrcatListForADStatus ?? this.contrcatListForADStatus,
      adminSignContractStatus:
          adminSignContractStatus ?? this.adminSignContractStatus,
      adminPermitDevelopingProjectStatus:
          adminPermitDevelopingProjectStatus ??
          this.adminPermitDevelopingProjectStatus,
    );
  }
}
