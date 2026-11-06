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
import 'package:two_dashboard/features/contact-us/presentation/bloc/contact_us_bloc.dart';

class FilterContactUs {
  // Filter With Seen & Approvment //
  void filterContactUs(
    BuildContext context,
    ValueNotifier<bool> seenSelected,
    ValueNotifier<bool> approvedSelected,
  ) {
    showDialog(
      context: context,

      builder:
          (context) => AlertDialog(
            title: FilterByText(),
            content: SizedBox(
              height: SizesConfig.dialogWidthSm + 20.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilterOptionTitle(
                    title: TextStrings.seenStatus,
                    iconData: Iconsax.eye,
                  ),
                  PaddingConfig.h8,
                  Row(
                    children: [
                      FilterOption(
                        option: TextStrings.seenStatus,
                        valueNotifier: seenSelected,
                      ),
                      PaddingConfig.w8,
                      FilterOption(
                        option: TextStrings.unSeenStatus,
                        valueNotifier: seenSelected,
                        isOposite: true,
                      ),
                    ],
                  ),
                  PaddingConfig.h16,
                  FilterOptionTitle(
                    title: TextStrings.approvment,
                    iconData: Iconsax.activity,
                  ),
                  PaddingConfig.h8,
                  Row(
                    children: [
                      FilterOption(
                        option: TextStrings.approved,
                        valueNotifier: approvedSelected,
                      ),
                      PaddingConfig.w8,
                      FilterOption(
                        option: TextStrings.unApproved,
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
                  context.read<ContactUsBloc>().add(
                    GetContactUsWithSeenAndApprovedEvent(
                      approvedFilter: approvedSelected.value ? 1 : 0,
                      seenFilter: seenSelected.value ? 1 : 0,
                    ),
                  );
                  context.pop();
                },
              ),
            ],
          ),
    );
  }
}
