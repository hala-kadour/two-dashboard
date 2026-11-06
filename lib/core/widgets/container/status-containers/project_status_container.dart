import 'package:flutter/material.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/network/enums.dart';

import '../../../../config/constants/sizes_config.dart';
import '../../../../config/theme/text_style.dart';
import '../custom_rounder_container.dart';

class ProjectStatusContainer extends StatelessWidget {
  const ProjectStatusContainer({super.key, required this.projectStatus});
  final TaskStatus projectStatus;

  @override
  Widget build(BuildContext context) {
    return CustomRounderContainer(
      showShadow: false,
      radius: SizesConfig.cardRadiusXs,
      padding: EdgeInsets.symmetric(
        vertical: SizesConfig.xs,
        horizontal: SizesConfig.md,
      ),
      backgroundColor: HelperFunctions.getTaskStatusBackgroundColor(
        projectStatus,
      ),
      child: Text(
        projectStatus.name.toLowerCase().toString(),
        style: AppTextStyle.bodyXs(
          color: HelperFunctions.getTaskStatusColor(projectStatus),
        ),
      ),
    );
  }
}
