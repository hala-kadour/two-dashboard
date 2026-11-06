import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/theme/text_style.dart';

class CustomSideMenuItem extends StatelessWidget {
  const CustomSideMenuItem({
    super.key,
    required this.icon,
    required this.color,
    required this.action,
  });
  final IconData icon;
  final Color color;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color),
        PaddingConfig.w8,
        Text(action, style: AppTextStyle.bodySm(color: color)),
      ],
    );
  }
}
