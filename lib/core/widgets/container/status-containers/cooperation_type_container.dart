import 'package:flutter/material.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/network/enums.dart';

import '../../../../config/constants/sizes_config.dart';
import '../../../../config/theme/text_style.dart';
import '../custom_rounder_container.dart';

class CooperationTypeContainer extends StatelessWidget {
  const CooperationTypeContainer({super.key, required this.cooperationType});
  final CooperationType cooperationType;

  @override
  Widget build(BuildContext context) {
    return CustomRounderContainer(
      showShadow: false,
      radius: SizesConfig.cardRadiusXs,
      padding: EdgeInsets.symmetric(
        vertical: SizesConfig.xs,
        horizontal: SizesConfig.md,
      ),
      backgroundColor: HelperFunctions.getCooperationTypeBackgroundColor(
        cooperationType,
      ),
      child: Text(
        HelperFunctions.getCooperationText(cooperationType),
        style: AppTextStyle.bodyXs(
          color: HelperFunctions.getCooperationTypeColor(cooperationType),
        ),
      ),
    );
  }
}
