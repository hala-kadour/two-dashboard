import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/assets_path.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/auth_services.dart';
import 'package:two_dashboard/core/functions/google_services.dart';
import 'package:two_dashboard/core/widgets/divider/divider_with_text.dart';

class GoogleGitRow extends StatelessWidget {
  const GoogleGitRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DividerWithText(text: " Or "),
        const SizedBox(height: SizesConfig.spaceBtwItems),
        InkWell(
          onTap: () {
            signInWithGoogle();
          },
          child: Expanded(
            child: Container(
              height: SizesConfig.boxSm,
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gray, width: .9),
                borderRadius: BorderRadius.circular(SizesConfig.borderRadiusSm),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    IconsPath.google,
                    width: SizesConfig.iconsMd,
                  ),
                  PaddingConfig.w8,
                  Text(
                    "Containe With Google",
                    style: AppTextStyle.buttonStyle(),
                  ),
                ],
              ),
            ),
          ),
        ),
        PaddingConfig.h8,
        InkWell(
          onTap: () {
            AuthService().signInWithGitHub();
          },
          child: Expanded(
            child: Container(
              height: SizesConfig.boxSm,
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gray, width: .9),
                borderRadius: BorderRadius.circular(SizesConfig.borderRadiusSm),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(IconsPath.githup),
                  PaddingConfig.w8,
                  Text(
                    "Containe With Githup",
                    style: AppTextStyle.buttonStyle(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
