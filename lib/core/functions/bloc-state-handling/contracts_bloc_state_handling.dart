import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/animation/error_status_animation.dart';
import 'package:two_dashboard/core/widgets/animation/unauthorized_status_animation.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/contracts/admin_contract_table.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/contracts/admin_loading_contract_table.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/contracts/cm_contract_table.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/contracts/cm_loading_contract_table.dart';
import 'package:two_dashboard/core/widgets/dialog/status/error_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/loading_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/not_authorized_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/success_dialog.dart';
import 'package:two_dashboard/features/contracts/presentation/bloc/contract_bloc.dart';

import '../../../config/routes/app_route_config.dart';

class ContractsBlocStateHandling {
  // add draft
  void addDraft(ContractState state, BuildContext context) {
    if (state.addDraftStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.addDraftStatus == CasualStatus.success) {
      context.pop();
      showSuccessDialog(context, () {
        context.pushReplacementNamed(AppRouteConfig.drafts);
        context.pop();
      });
      context.pop();
    } else if (state.addDraftStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.errorMessage);
    } else if (state.addDraftStatus == CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  // ** Contract Manager ** //
  Widget getCMContractsTable(ContractState state) {
    if (state.contrcatListForCMStatus == CasualStatus.loading) {
      return const CMLoadingContractTable();
    } else if (state.contrcatListForCMStatus == CasualStatus.success) {
      return CMContractTable(contractList: state.contrcatListForCM);
    } else if (state.contrcatListForCMStatus == CasualStatus.failure) {
      return Center(
        child: ErrorStatusAnimation(errorMessage: state.errorMessage),
      );
    } else if (state.contrcatListForCMStatus == CasualStatus.not_authorized) {
      return Center(child: UnauthorizedStatusAnimation());
    } else {
      return const SizedBox();
    }
  }

  void approveCMContract(ContractState state, BuildContext context) {
    if (state.approveContractByCMStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.approveContractByCMStatus == CasualStatus.success) {
      context.pop();
      context.read<ContractBloc>().add(ContractManagerShowContractsEvent());
      showSuccessDialog(context, () {
        context.pop();
      });
    } else if (state.approveContractByCMStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.errorMessage);
    }
  }

  void updateCMContract(ContractState state, BuildContext context) {
    if (state.updateContractByCMStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.updateContractByCMStatus == CasualStatus.success) {
      context.pop();
      showSuccessDialog(context, () {
        context.pop();
      });
    } else if (state.updateContractByCMStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.errorMessage);
    }
  }

  // ** Project Manager ** //
  void approvePMContract(ContractState state, BuildContext context) {
    if (state.approveContractByPMStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.approveContractByPMStatus == CasualStatus.success) {
      context.pop();
      showSuccessDialog(context, () {
        context.pop();
      });
    } else if (state.approveContractByPMStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.errorMessage);
    }
  }

  void updatePMContract(ContractState state, BuildContext context) {
    if (state.updateContractByPMStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.updateContractByPMStatus == CasualStatus.success) {
      context.pop();
      showSuccessDialog(context, () {
        context.pop();
      });
    } else if (state.updateContractByPMStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.errorMessage);
    }
  }

  // ** Admin ** //

  Widget getAdminContractsTable(ContractState state) {
    if (state.contrcatListForADStatus == CasualStatus.loading) {
      return const AdminLoadingContractTable();
    } else if (state.contrcatListForADStatus == CasualStatus.success) {
      return AdminContractTable(contractList: state.contrcatListForAD);
    } else if (state.contrcatListForADStatus == CasualStatus.failure) {
      return Center(
        child: ErrorStatusAnimation(errorMessage: state.errorMessage),
      );
    } else if (state.contrcatListForADStatus == CasualStatus.not_authorized) {
      return Center(child: UnauthorizedStatusAnimation());
    } else {
      return const SizedBox();
    }
  }

  void adminSignContract(ContractState state, BuildContext context) {
    if (state.adminSignContractStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.adminSignContractStatus == CasualStatus.success) {
      context.pop();
      context.read<ContractBloc>().add(
        AdminShowContractsEvent(adminSignFilter: 1),
      );
      showSuccessDialog(context, () {
        context.pop();
      });
    } else if (state.adminSignContractStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.errorMessage);
    }
  }

  void adminPermitDevelopingProject(ContractState state, BuildContext context) {
    if (state.adminPermitDevelopingProjectStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.adminPermitDevelopingProjectStatus ==
        CasualStatus.success) {
      context.pop();
      context.read<ContractBloc>().add(
        AdminShowContractsEvent(adminSignFilter: 1),
      );
      showSuccessDialog(context, () {
        context.pop();
      });
    } else if (state.adminPermitDevelopingProjectStatus ==
        CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.errorMessage);
    }
  }

  // Get Contract Popumenu
  // Widget getContractsPopuMenu(
  //   ContractState state,
  //   ContractEntity? contractEntity,
  //   void Function(ContractEntity)? onSelected,
  // ) {
  //   if (state.contrcatListStatus == CasualStatus.loading) {
  //     return const CustomDropdownLoading();
  //   } else if (state.contrcatListStatus == CasualStatus.success) {
  //     return CustomPopuMenuForContractEntity(
  //       selectYour: "Contract File",
  //       value: contractEntity,
  //       items:
  //           state.contractList.map((contract) {
  //             return PopupMenuItem(
  //               value: contract,
  //               child: Text(contract.contractPath),
  //             );
  //           }).toList(),
  //       onSelected: onSelected,
  //     );
  //   } else if (state.contrcatListStatus == CasualStatus.failure) {
  //     return const Text("No Contrcats");
  //   } else {
  //     return const SizedBox();
  //   }
  // }
}
