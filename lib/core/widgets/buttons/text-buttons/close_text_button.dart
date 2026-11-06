import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';

class CloseTextButton extends StatelessWidget {
  const CloseTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.pop();
      },
      child: Text(
        TextStrings.close,
        style: AppTextStyle.textButtonStyle(color: AppColors.black),
      ),
    );
  }
}
