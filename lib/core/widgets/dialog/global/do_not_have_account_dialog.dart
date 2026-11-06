import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/strings/assets_path.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/buttons/hovered-buttons/custom_cartoon_button.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/cancel_text_button.dart';

void doNotHaveAccountDialog(BuildContext context) {
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
                JsonPath.fingerPrint,
                width: 120,
                height: 120,
                repeat: false,
              ),
              PaddingConfig.h16,
              Text(
                "You Do't Have An Acount!",
                textAlign: TextAlign.center,
                style: AppTextStyle.headerSm(color: AppColors.blueShade2),
              ),
              PaddingConfig.h8,
              Text(
                "please make an account first.",
                textAlign: TextAlign.center,
                style: AppTextStyle.bodyMd(color: AppColors.blueShade1),
              ),
              PaddingConfig.h24,
              CustomCartoonButton(
                title: "Make An Acount",
                onTap: () => context.pushNamed(AppRouteConfig.signup),
              ),
              PaddingConfig.h8,
              CancelTextButton(),
            ],
          ),
        ),
      );
    },
  );
}
