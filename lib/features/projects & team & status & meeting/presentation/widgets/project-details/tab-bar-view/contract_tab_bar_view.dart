import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/contracts_bloc_state_handling.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/create_elevated_button.dart';
import 'package:two_dashboard/core/widgets/buttons/hovered-buttons/approved_button.dart';
import 'package:two_dashboard/core/widgets/buttons/hovered-buttons/edit_button.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/field_status_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/time_ago_container.dart';
import 'package:two_dashboard/core/widgets/texts/linked_text.dart';
import 'package:two_dashboard/features/contracts/presentation/bloc/contract_bloc.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/contract.dart';

class ContractTabBarView extends StatefulWidget {
  const ContractTabBarView({
    super.key,
    required this.projectId,
    required this.contract,
  });
  final int projectId;
  final Contract? contract;

  @override
  State<ContractTabBarView> createState() => _StatusTabBarViewState();
}

class _StatusTabBarViewState extends State<ContractTabBarView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CreateElevatedButton(
                  addingType: "Draft",
                  onPressed:
                      () => context.pushNamed(
                        AppRouteConfig.createDraft,
                        pathParameters: {'id': widget.projectId.toString()},
                      ),
                ),
              ],
            ),
            PaddingConfig.h32,
            if (widget.contract != null)
              CustomRounderContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: AppColors.gray,
                          ),
                          child: Text(
                            "PDF",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.fontLightGray,
                            ),
                          ),
                        ),
                        PaddingConfig.w8,
                        LinkedText(link: widget.contract!.contract),
                      ],
                    ),
                    // Project Managet Approvment
                    FieldStatusContainer(
                      fieldStatus:
                          widget.contract!.projectManagerStatus == 0
                              ? FieldStatus.unApproved
                              : FieldStatus.approved,
                    ),
                    // Last Time was Updated
                    TimeAgoContainer(date: widget.contract!.updatedAt),
                    Row(
                      children: [
                        BlocListener<ContractBloc, ContractState>(
                          listener: (context, state) {
                            ContractsBlocStateHandling().approvePMContract(
                              state,
                              context,
                            );
                          },
                          listenWhen:
                              (previous, current) =>
                                  previous.approveContractByPMStatus !=
                                  current.approveContractByPMStatus,
                          child: ApprovedButton(
                            onTap:
                                () => context.read<ContractBloc>().add(
                                  ProjectManagerApproveContractEvent(
                                    contractId: widget.contract!.id,
                                    projectId: widget.projectId,
                                  ),
                                ),
                          ),
                        ),
                        PaddingConfig.w8,
                        EditButton(
                          onTap:
                              () => context.pushNamed(
                                AppRouteConfig.pmUpdateContract,
                                pathParameters: {
                                  'pId': widget.projectId.toString(),
                                  'cId': widget.contract!.id.toString(),
                                },
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            PaddingConfig.h16,
            if (widget.contract != null)
              Text("Client Edit Requests", style: AppTextStyle.bodyMd()),
            if (widget.contract != null)
              Text(
                widget.contract?.clientEditRequest ?? "No Edit Requests yet",
              ),
            PaddingConfig.h48,
          ],
        ),
      ),
    );
  }
}
