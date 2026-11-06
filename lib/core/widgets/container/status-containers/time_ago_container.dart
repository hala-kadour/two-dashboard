import 'package:flutter/material.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';

import '../../../../config/constants/sizes_config.dart';
import '../../../../config/theme/text_style.dart';
import '../custom_rounder_container.dart';

class TimeAgoContainer extends StatelessWidget {
  const TimeAgoContainer({super.key, required this.date});
  final DateTime date;

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
        "${HelperFunctions.getTimeAgo(date)} left",
        style: AppTextStyle.bodyXs(color: AppColors.blueShade2),
      ),
    );
  }
}
