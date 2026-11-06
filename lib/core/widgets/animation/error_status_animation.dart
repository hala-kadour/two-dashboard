import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/strings/assets_path.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/buttons/hovered-buttons/refresh_button.dart';

class ErrorStatusAnimation extends StatelessWidget {
  const ErrorStatusAnimation({
    super.key,
    required this.errorMessage,
    this.onTap,
  });
  final String errorMessage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          height: 300,
          child:
              (errorMessage.toLowerCase().contains("unexpected token"))
                  ? Lottie.asset(JsonPath.lock)
                  : (errorMessage.toLowerCase().contains("timeout"))
                  ? Lottie.asset(JsonPath.noConnection)
                  : Lottie.asset(JsonPath.failed),
        ),
        PaddingConfig.h8,
        Text(
          (errorMessage.toLowerCase().contains("unexpected token"))
              ? TextStrings.sorrySir
              : (errorMessage.toLowerCase().contains("timeout"))
              ? TextStrings.netWorkError
              : errorMessage,
          style: AppTextStyle.bodyMd(
            color:
                (errorMessage.toLowerCase().contains("unexpected token"))
                    ? AppColors.blueShade2
                    : (errorMessage.toLowerCase().contains("timeout"))
                    ? AppColors.blueShade2
                    : AppColors.redShade2,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.fade,
        ),
        PaddingConfig.h8,
        if (errorMessage.toLowerCase().contains("timeout"))
          RefreshButton(onTap: onTap),
      ],
    );
  }
}
