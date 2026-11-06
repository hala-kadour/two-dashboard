import 'package:flutter/material.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/network/enums.dart';

import '../../../../config/constants/sizes_config.dart';
import '../../../../config/theme/text_style.dart';
import '../custom_rounder_container.dart';

class PriorityContainer extends StatelessWidget {
  const PriorityContainer({super.key, required this.priority});
  final TaskPriority priority;

  @override
  Widget build(BuildContext context) {
    return CustomRounderContainer(
      showShadow: false,
      radius: SizesConfig.cardRadiusXs,
      padding: EdgeInsets.symmetric(
        vertical: SizesConfig.xs,
        horizontal: SizesConfig.md,
      ),
      backgroundColor: HelperFunctions.getPriorityBackgroundColor(priority),
      child: Text(
        priority.name.toUpperCase().toString(),
        style: AppTextStyle.bodyXs(
          color: HelperFunctions.getPriorityColor(priority),
        ),
      ),
    );
  }
}
