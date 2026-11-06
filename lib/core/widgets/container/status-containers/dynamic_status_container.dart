import 'package:flutter/material.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';

import '../../../../config/constants/sizes_config.dart';
import '../../../../config/theme/text_style.dart';
import '../custom_rounder_container.dart';

class DynamicStatusContainer extends StatelessWidget {
  const DynamicStatusContainer({
    super.key,
    required this.status,
    this.fontColor,
    this.color,
  });
  final String status;
  final Color? fontColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CustomRounderContainer(
      showShadow: false,
      radius: SizesConfig.cardRadiusXs,
      padding: EdgeInsets.symmetric(
        vertical: SizesConfig.xs,
        horizontal: SizesConfig.md,
      ),
      backgroundColor: color ?? HelperFunctions.getTextBackgroundColor(status),
      child: Text(
        status.toLowerCase(),
        style: AppTextStyle.bodyXs(
          color: fontColor ?? HelperFunctions.getTextColor(status),
        ),
      ),
    );
  }
}
