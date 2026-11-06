import 'package:flutter/material.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';

class SideBarTitle extends StatelessWidget {
  const SideBarTitle({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon(icon, size: SizesConfig.iconsSm, color: AppColors.white),
        // PaddingConfig.w8,
        Text(
          title.toUpperCase(),
          style: AppTextStyle.bodySm(
            color: AppColors.white,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
