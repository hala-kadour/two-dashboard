import 'package:flutter/material.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';

import '../../../../config/constants/sizes_config.dart';
import '../../../../config/theme/text_style.dart';
import '../custom_rounder_container.dart';

class DurationContainer extends StatelessWidget {
  const DurationContainer({
    super.key,
    required this.startDate,
    required this.endDate,
  });
  final DateTime startDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    return CustomRounderContainer(
      showShadow: false,
      radius: SizesConfig.cardRadiusXs,
      padding: EdgeInsets.symmetric(
        vertical: SizesConfig.xs,
        horizontal: SizesConfig.md,
      ),
      backgroundColor: AppColors.blueShade1,
      child: Text(
        "${HelperFunctions.getDurationText(startDate, endDate)} left",
        style: AppTextStyle.bodyXs(color: AppColors.blueShade2),
      ),
    );
  }
}
