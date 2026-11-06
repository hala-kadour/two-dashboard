import 'package:flutter/material.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';

class PreviewTextButton extends StatelessWidget {
  const PreviewTextButton({super.key, required this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        TextStrings.preview,
        style: AppTextStyle.textButtonStyle(color: AppColors.greenShade2),
      ),
    );
  }
}
