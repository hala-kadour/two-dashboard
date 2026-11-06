import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';

class UserInfoRow extends StatelessWidget {
  const UserInfoRow({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyle.bodyLg(color: AppColors.greenShade2)),
          Container(
            width: MediaQuery.sizeOf(context).width * .35,
            padding: EdgeInsets.all(SizesConfig.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizesConfig.borderRadiusMd),
              border: Border.all(color: AppColors.gray, width: 1),
            ),
            child: Text(
              value,
              style: AppTextStyle.bodyMd(color: AppColors.rockShade2),
            ),
          ),
        ],
      ),
    );
  }
}
