import 'package:flutter/material.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/network/enums.dart';

import '../../../../config/constants/sizes_config.dart';
import '../../../../config/theme/text_style.dart';
import '../custom_rounder_container.dart';

class ProjectTypeStatusContainer extends StatelessWidget {
  const ProjectTypeStatusContainer({super.key, required this.projectType});
  final ProjectType projectType;

  @override
  Widget build(BuildContext context) {
    return CustomRounderContainer(
      showShadow: false,
      radius: SizesConfig.cardRadiusXs,
      padding: EdgeInsets.symmetric(
        vertical: SizesConfig.xs,
        horizontal: SizesConfig.md,
      ),
      backgroundColor: HelperFunctions.getProjectTypeBackgroundColor(
        projectType,
      ),
      child: Text(
        HelperFunctions.getProjectTypeText(projectType),
        style: AppTextStyle.bodyXs(
          color: HelperFunctions.getProjectTypeColor(projectType),
        ),
      ),
    );
  }
}
