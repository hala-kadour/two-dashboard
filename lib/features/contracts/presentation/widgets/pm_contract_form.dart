import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/contracts_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/buttons/icon-buttons/back_button.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/core/widgets/dialog/global/forget_some_thing_dialog.dart';
import 'package:two_dashboard/core/widgets/divider/custom_page_divider.dart';
import 'package:two_dashboard/core/widgets/texts/page_title.dart';
import 'package:two_dashboard/features/auth/presentation/bloc/auth_role_profile_bloc.dart';

import '../../../../config/routes/app_route_config.dart';
import '../../../../core/widgets/breadcrumbs/breadcumbs_item.dart';
import '../../../../core/widgets/buttons/elevated-buttons/desmiss_elevated_buttom.dart';
import '../../../../core/widgets/buttons/elevated-buttons/save_elevated_button.dart';
import '../../../../core/widgets/layouts/templates/page_template.dart';
import '../../../auth/presentation/widgets/fill-profile/fetch_file_box.dart';
import '../bloc/contract_bloc.dart';

class PmContractForm extends StatefulWidget {
  const PmContractForm({
    super.key,
    required this.projectId,
    required this.contractId,
  });
  final String projectId;
  final String contractId;

  @override
  State<PmContractForm> createState() => _PmContractFormState();
}

class _PmContractFormState extends State<PmContractForm> {
  String? pdfByte;
  void updatePDFBytes(String? bytes) {
    setState(() {
      pdfByte = bytes;
    });
  }

  @override
  void didChangeDependencies() {
    context.read<AuthRoleProfileBloc>().add(ShowClientsEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContractBloc, ContractState>(
      listener: (context, state) {
        ContractsBlocStateHandling().updatePMContract(state, context);
      },
      listenWhen:
          (previous, current) =>
              previous.updateContractByPMStatus !=
              current.updateContractByPMStatus,
      child: PageTemplate(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Breadcrumbs(
              paths: [
                AppRouteConfig.projectDetails,
                AppRouteConfig.pmUpdateContract,
              ],
              pages: ["Project Details", "Update contract"],
            ),
            PaddingConfig.h16,
            Row(
              children: [
                CustomBackButton(),
                PaddingConfig.w8,
                PageTitle(pageTitle: "New Contract File"),
              ],
            ),
            CustomPageDivider(),
            PaddingConfig.h24,
            CustomRounderContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Contract File", style: AppTextStyle.bodySm()),
                  PaddingConfig.h32,
                  FetchFileBox(
                    changeStyle: true,
                    fileB64: pdfByte,
                    onUpdate: updatePDFBytes,
                  ),
                  PaddingConfig.h16,
                ],
              ),
            ),
            PaddingConfig.h24,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const DesmissElevatedButtom(),
                PaddingConfig.w16,
                SaveElevatedButton(
                  onPressed: () {
                    if (pdfByte == null) {
                      forgetSomeThingDialog(context, "The Contract");
                    } else {
                      context.read<ContractBloc>().add(
                        ProjectManagerUpdateContractEvent(
                          pdfFilePath: pdfByte!,
                          contractId: widget.contractId,
                          projectId: widget.projectId,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
