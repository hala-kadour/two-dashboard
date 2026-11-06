import 'package:flutter/material.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/network/enums.dart';

import '../../../../config/constants/sizes_config.dart';
import '../../../../config/theme/text_style.dart';
import '../custom_rounder_container.dart';

class VisibilityStatusContainer extends StatelessWidget {
  const VisibilityStatusContainer({super.key, required this.visibility});
  final ProjectVisibility visibility;

  @override
  Widget build(BuildContext context) {
    return CustomRounderContainer(
      showShadow: false,
      radius: SizesConfig.cardRadiusXs,
      padding: EdgeInsets.symmetric(
        vertical: SizesConfig.xs,
        horizontal: SizesConfig.md,
      ),
      backgroundColor: HelperFunctions.getVisibiltyBackGroundColor(visibility),
      child: Text(
        visibility.name.toLowerCase().toString(),
        style: AppTextStyle.bodyXs(
          color: HelperFunctions.getVisibiltyColor(visibility),
        ),
      ),
    );
  }
}
