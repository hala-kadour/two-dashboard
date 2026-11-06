import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/cancel_text_button.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/save_text_button.dart';
import 'package:two_dashboard/core/widgets/images/fetch_image_box.dart';

class ContractsDialogs {
  // Add signature
  Future<dynamic> addSignatureDialog(
    BuildContext context,
    int contractId,
    String? signature,
    dynamic Function(String?) onUpdate,
  ) {
    return showDialog(
      context: context,
      builder:
          (context) => SizedBox(
            height: SizesConfig.dialogHightXs,
            width: SizesConfig.dialogWidthMd,
            child: AlertDialog(
              title: Text(
                TextStrings.addClientSign,
                style: AppTextStyle.bodyLg(),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FetchImageBox(imageB64: signature, onUpdate: onUpdate),
                ],
              ),
              actions: [
                const CancelTextButton(),
                SaveTextButton(
                  onPressed: () {
                    if (signature != null) {
                      // context.read<ContractBloc>().add(
                      //   AddSignEvent(
                      //     signature: signature,
                      //     contractId: contractId,
                      //   ),
                      // );
                      context.pop();
                    }
                  },
                ),
              ],
            ),
          ),
    );
  }
}
