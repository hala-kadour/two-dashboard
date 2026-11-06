import 'package:bloc/bloc.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/contract_param.dart';
import 'package:two_dashboard/core/services/shared_preferences_services.dart';
import 'package:two_dashboard/features/contracts/data/models/contract_model.dart';
import 'package:two_dashboard/features/contracts/domain/usecases/add_draft_usecase.dart';
import 'package:two_dashboard/features/contracts/domain/usecases/admin_sign_contract_usecase.dart';
import 'package:two_dashboard/features/contracts/domain/usecases/contract_manager_approve_contract_usecase.dart';
import 'package:two_dashboard/features/contracts/domain/usecases/contract_manager_update_contract_usecase.dart';
import 'package:two_dashboard/features/contracts/domain/usecases/project_manager_approve_contract_usecase.dart';
import 'package:two_dashboard/features/contracts/domain/usecases/project_manager_update_contract_usecase.dart';
import 'package:two_dashboard/features/contracts/domain/usecases/show_admin_contract_list_usecase.dart';
import 'package:two_dashboard/features/contracts/domain/usecases/show_contract_list_usecase.dart';
import 'package:two_dashboard/features/contracts/domain/usecases/show_contract_manager_contract_list_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/project/admin_permit_developing_project_usecase.dart';

part 'contract_event.dart';
part 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  final AddDraftUsecase addDraftUsecase;
  final AdminSignContractUsecase adminSignContractUsecase;
  final ContractManagerApproveContractUsecase
  contractManagerApproveContractUsecase;
  final ContractManagerUpdateContractUsecase
  contractManagerUpdateContractUsecase;
  final ProjectManagerApproveContractUsecase
  projectManagerApproveContractUsecase;
  final ProjectManagerUpdateContractUsecase projectManagerUpdateContractUsecase;
  final ShowAdminContractListUsecase showAdminContractListUsecase;
  final ShowContractListUsecase showContractListUsecase;
  final ShowContractManagerContractListUsecase
  showContractManagerContractListUsecase;
  final AdminPermitDevelopingProjectUsecase adminPermitDevelopingProjectUsecase;

  ContractBloc(
    this.addDraftUsecase,
    this.adminSignContractUsecase,
    this.contractManagerApproveContractUsecase,
    this.contractManagerUpdateContractUsecase,
    this.projectManagerApproveContractUsecase,
    this.projectManagerUpdateContractUsecase,
    this.showAdminContractListUsecase,
    this.showContractListUsecase,
    this.showContractManagerContractListUsecase,
    this.adminPermitDevelopingProjectUsecase,
  ) : super(ContractState()) {
    // add draft
    on<AddDraftEvent>((event, emit) async {
      emit(state.copyWith(addDraftStatus: CasualStatus.loading));
      final token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await addDraftUsecase.call(
          AddDraftParam(
            token: token,
            pdfFilePath: event.pdfFilePath,
            projectId: event.projectId,
          ),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              addDraftStatus: CasualStatus.failure,
              errorMessage: l.message,
            ),
          ),
          (r) => emit(state.copyWith(addDraftStatus: CasualStatus.success)),
        );
      } else {
        emit(state.copyWith(addDraftStatus: CasualStatus.not_authorized));
      }
    });
    // show contract
    on<ShowContractsEvent>((event, emit) async {
      emit(state.copyWith(contrcatListStatus: CasualStatus.loading));
      final token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await showContractListUsecase.call(
          ShowContractParam(token: token, stateFilter: event.stateFilter),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              contrcatListStatus: CasualStatus.failure,
              errorMessage: l.message,
            ),
          ),
          (r) => emit(
            state.copyWith(
              contrcatListStatus: CasualStatus.success,
              contrcatList: r,
            ),
          ),
        );
      } else {
        emit(state.copyWith(addDraftStatus: CasualStatus.not_authorized));
      }
    });
    ///////////////////////////////////////////////////////////////////
    /// *** CONTRACT - MANAGER *** ///
    // show Contract manager contrcats list
    on<ContractManagerShowContractsEvent>((event, emit) async {
      emit(state.copyWith(contrcatListForCMStatus: CasualStatus.loading));
      final token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await showContractManagerContractListUsecase.call(token);
        result.fold(
          (l) => emit(
            state.copyWith(
              contrcatListForCMStatus: CasualStatus.failure,
              errorMessage: l.message,
            ),
          ),
          (r) => emit(
            state.copyWith(
              contrcatListForCMStatus: CasualStatus.success,
              contrcatListForCM: r,
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(contrcatListForCMStatus: CasualStatus.not_authorized),
        );
      }
    });
    // contract manager update contract
    on<ContractManagerUpdateContractEvent>((event, emit) async {
      emit(state.copyWith(updateContractByCMStatus: CasualStatus.loading));
      final token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await contractManagerUpdateContractUsecase.call(
          CMUpdateContractParam(
            token: token,
            pdfFilePath: event.pdfFilePath,
            contractId: event.contractId,
          ),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              updateContractByCMStatus: CasualStatus.failure,
              errorMessage: l.message,
            ),
          ),
          (r) => emit(
            state.copyWith(updateContractByCMStatus: CasualStatus.success),
          ),
        );
      } else {
        emit(
          state.copyWith(updateContractByCMStatus: CasualStatus.not_authorized),
        );
      }
    });
    // contract manager approve contract
    on<ContractManagerApproveContractEvent>((event, emit) async {
      emit(state.copyWith(approveContractByCMStatus: CasualStatus.loading));
      final token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await contractManagerApproveContractUsecase.call(
          ApproveContractParam(
            token: token,
            contractId: event.contractId,
            projectId: event.projectId,
          ),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              approveContractByCMStatus: CasualStatus.failure,
              errorMessage: l.message,
            ),
          ),
          (r) => emit(
            state.copyWith(approveContractByCMStatus: CasualStatus.success),
          ),
        );
      } else {
        emit(
          state.copyWith(
            approveContractByCMStatus: CasualStatus.not_authorized,
          ),
        );
      }
    });
    ///////////////////////////////////////////////////////////////////
    /// *** PROJECT - MANAGER *** ///
    // project manager update contract
    on<ProjectManagerUpdateContractEvent>((event, emit) async {
      emit(state.copyWith(updateContractByPMStatus: CasualStatus.loading));
      final token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await projectManagerUpdateContractUsecase.call(
          PMUpdateContractParam(
            token: token,
            pdfFilePath: event.pdfFilePath,
            contractId: event.contractId,
            projectId: event.projectId,
          ),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              updateContractByPMStatus: CasualStatus.failure,
              errorMessage: l.message,
            ),
          ),
          (r) => emit(
            state.copyWith(updateContractByPMStatus: CasualStatus.success),
          ),
        );
      } else {
        emit(
          state.copyWith(updateContractByPMStatus: CasualStatus.not_authorized),
        );
      }
    });
    // project manager approve contract
    on<ProjectManagerApproveContractEvent>((event, emit) async {
      emit(state.copyWith(approveContractByPMStatus: CasualStatus.loading));
      final token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await projectManagerApproveContractUsecase.call(
          ApproveContractParam(
            token: token,
            contractId: event.contractId,
            projectId: event.projectId,
          ),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              approveContractByPMStatus: CasualStatus.failure,
              errorMessage: l.message,
            ),
          ),
          (r) => emit(
            state.copyWith(approveContractByPMStatus: CasualStatus.success),
          ),
        );
      } else {
        emit(
          state.copyWith(
            approveContractByPMStatus: CasualStatus.not_authorized,
          ),
        );
      }
    });
    ///////////////////////////////////////////////////////////////////
    /// *** ADMIN *** ///
    // admin show contract
    on<AdminShowContractsEvent>((event, emit) async {
      emit(state.copyWith(contrcatListForADStatus: CasualStatus.loading));
      final token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await showAdminContractListUsecase.call(
          ShowAdminContractParam(
            token: token,
            adminSignFilter: event.adminSignFilter,
          ),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              contrcatListForADStatus: CasualStatus.failure,
              errorMessage: l.message,
            ),
          ),
          (r) => emit(
            state.copyWith(
              contrcatListForADStatus: CasualStatus.success,
              contrcatListForAD: r,
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(contrcatListForADStatus: CasualStatus.not_authorized),
        );
      }
    });
    // admin sign contract
    on<AdminSignContractEvent>((event, emit) async {
      emit(state.copyWith(adminSignContractStatus: CasualStatus.loading));
      final token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await adminSignContractUsecase.call(
          AdminSignContractParam(
            token: token,
            signature: event.signature,
            contractId: event.contractId,
          ),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              adminSignContractStatus: CasualStatus.failure,
              errorMessage: l.message,
            ),
          ),
          (r) => emit(
            state.copyWith(adminSignContractStatus: CasualStatus.success),
          ),
        );
      } else {
        emit(
          state.copyWith(adminSignContractStatus: CasualStatus.not_authorized),
        );
      }
    });
    // Admin Permit Developing Project
    on<AdminPermitDevelopingProjectEvent>((event, emit) async {
      emit(
        state.copyWith(
          adminPermitDevelopingProjectStatus: CasualStatus.loading,
        ),
      );
      final String? token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await adminPermitDevelopingProjectUsecase.call(
          TokenWithIdParam(token: token, id: event.projectId),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              adminPermitDevelopingProjectStatus: CasualStatus.failure,
              errorMessage: l.message,
            ),
          ),
          (r) => emit(
            state.copyWith(
              adminPermitDevelopingProjectStatus: CasualStatus.success,
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            adminPermitDevelopingProjectStatus: CasualStatus.not_authorized,
          ),
        );
      }
    });
  }
}
