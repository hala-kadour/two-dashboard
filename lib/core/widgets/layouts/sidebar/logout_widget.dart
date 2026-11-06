import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/assets_path.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: SizesConfig.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SvgPicture.asset(
              IconsPath.logout,
              // ignore: deprecated_member_use
              color: AppColors.white,
            ),
          ),
          Text(
            TextStrings.logout,
            style: AppTextStyle.buttonStyle(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
