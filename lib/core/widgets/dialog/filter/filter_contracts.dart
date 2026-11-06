import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/apply_text_button.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/cancel_text_button.dart';
import 'package:two_dashboard/core/widgets/dialog/filter/filter_custom_widgets.dart';
import 'package:two_dashboard/features/contracts/presentation/bloc/contract_bloc.dart';

class FilterContracts {
  // Contracts Filter
  void filterContracts(
    BuildContext context,
    ValueNotifier<bool> approvedSelected,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: FilterByText(),
            content: SizedBox(
              height: SizesConfig.dialogWidthSm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilterOptionTitle(
                    title: TextStrings.signature,
                    iconData: Iconsax.designtools,
                  ),
                  PaddingConfig.h24,
                  Row(
                    children: [
                      FilterOption(
                        option: TextStrings.signed,
                        valueNotifier: approvedSelected,
                      ),
                      PaddingConfig.w8,
                      FilterOption(
                        option: TextStrings.nonSigned,
                        valueNotifier: approvedSelected,
                        isOposite: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              const CancelTextButton(),
              ApplyTextButton(
                onPressed: () {
                  context.read<ContractBloc>().add(
                    AdminShowContractsEvent(
                      adminSignFilter: approvedSelected.value ? 1 : 0,
                    ),
                  );
                  context.pop();
                },
              ),
            ],
          ),
    );
  }

  // Filter Drafts
  void filterDrafts(
    BuildContext context,
    ValueNotifier<bool> approvedSelected,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: FilterByText(),
            content: SizedBox(
              height: SizesConfig.dialogWidthSm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilterOptionTitle(
                    title: "Approvment",
                    iconData: Iconsax.activity,
                  ),
                  PaddingConfig.h24,
                  Row(
                    children: [
                      FilterOption(
                        option: "approved",
                        valueNotifier: approvedSelected,
                      ),
                      PaddingConfig.w8,
                      FilterOption(
                        option: "not approved",
                        valueNotifier: approvedSelected,
                        isOposite: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              const CancelTextButton(),
              ApplyTextButton(
                onPressed: () {
                  // context.read<ContractBloc>().add(
                  //   GetDrafEvent(filter: approvedSelected.value ? 1 : 0),
                  // );
                  context.pop();
                },
              ),
            ],
          ),
    );
  }
}
