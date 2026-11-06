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

class CreateDraftForm extends StatefulWidget {
  const CreateDraftForm({super.key, required this.projectId});
  final int projectId;

  @override
  State<CreateDraftForm> createState() => _CreateDraftFormState();
}

class _CreateDraftFormState extends State<CreateDraftForm> {
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
        ContractsBlocStateHandling().addDraft(state, context);
      },
      listenWhen:
          (previous, current) =>
              previous.addDraftStatus != current.addDraftStatus,
      child: PageTemplate(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Breadcrumbs(
              paths: [
                AppRouteConfig.projectDetails,
                AppRouteConfig.createDraft,
              ],
              pages: ["Project Details", "Add Draft"],
            ),
            PaddingConfig.h16,
            Row(
              children: [
                CustomBackButton(),
                PaddingConfig.w8,
                PageTitle(pageTitle: "Add Draft"),
              ],
            ),
            CustomPageDivider(),
            PaddingConfig.h24,
            CustomRounderContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Draft File", style: AppTextStyle.bodySm()),
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
                      forgetSomeThingDialog(context, "The Draft");
                    } else {
                      context.read<ContractBloc>().add(
                        AddDraftEvent(
                          pdfFilePath: pdfByte!,
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
