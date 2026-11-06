import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/assets_path.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/close_elevated_button.dart';

void showErrorDialog(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(SizesConfig.borderRadiusMd),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                (errorMessage.toLowerCase().contains("unexpected token"))
                    ? JsonPath.lock
                    : (errorMessage.toLowerCase().contains("timeout"))
                    ? JsonPath.noConnection
                    : JsonPath.failed,
                width: 120,
                height: 120,
                repeat: false,
              ),
              PaddingConfig.h16,
              Text(
                TextStrings.error,
                textAlign: TextAlign.center,
                style: AppTextStyle.headerSm(
                  color:
                      (errorMessage.toLowerCase().contains("unexpected token"))
                          ? AppColors.blueShade2
                          : (errorMessage.toLowerCase().contains("timeout"))
                          ? AppColors.blueShade2
                          : AppColors.redShade2,
                ),
              ),
              PaddingConfig.h8,
              Text(
                (errorMessage.toLowerCase().contains("unexpected token"))
                    ? "You are not allowed\nto do that."
                    : (errorMessage.toLowerCase().contains("timeout"))
                    ? "There is no internet."
                    : errorMessage,
                textAlign: TextAlign.center,
                style: AppTextStyle.bodyMd(
                  color:
                      (errorMessage.toLowerCase().contains("unexpected token"))
                          ? AppColors.blueShade2.withOpacity(0.8)
                          : (errorMessage.toLowerCase().contains("timeout"))
                          ? AppColors.blueShade2.withOpacity(0.8)
                          : AppColors.redShade2.withOpacity(0.7),
                ),
                overflow: TextOverflow.fade,
              ),
              PaddingConfig.h24,
              CloseElevatedButton(),
            ],
          ),
        ),
      );
    },
  );
}
