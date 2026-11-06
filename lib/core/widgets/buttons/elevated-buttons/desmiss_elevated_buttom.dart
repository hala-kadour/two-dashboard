import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';

class DesmissElevatedButtom extends StatelessWidget {
  const DesmissElevatedButtom({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        fixedSize: const Size(
          SizesConfig.buttonWidth,
          SizesConfig.buttonHeight,
        ),
        side: BorderSide(color: AppColors.navy),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizesConfig.buttonRadius),
        ),
      ),
      onPressed: () => context.pop(),
      child: Text(
        TextStrings.dismiss,
        style: AppTextStyle.buttonStyle(color: AppColors.navy),
      ),
    );
  }
}
