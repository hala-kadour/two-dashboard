import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/strings/assets_path.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';

class UnauthorizedStatusAnimation extends StatelessWidget {
  const UnauthorizedStatusAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: Lottie.asset(JsonPath.fingerPrint),
        ),
        PaddingConfig.w16,
        Text(
          TextStrings.noToken,
          style: AppTextStyle.bodySm(color: AppColors.blueShade2),
        ),
      ],
    );
  }
}
