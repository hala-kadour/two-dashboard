import 'package:flutter/material.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/network/enums.dart';

import '../../../../config/constants/sizes_config.dart';
import '../../../../config/theme/text_style.dart';
import '../custom_rounder_container.dart';

class FieldStatusContainer extends StatelessWidget {
  const FieldStatusContainer({super.key, required this.fieldStatus});
  final FieldStatus fieldStatus;

  @override
  Widget build(BuildContext context) {
    return CustomRounderContainer(
      showShadow: false,
      radius: SizesConfig.cardRadiusXs,
      padding: EdgeInsets.symmetric(
        vertical: SizesConfig.xs,
        horizontal: SizesConfig.md,
      ),
      backgroundColor: HelperFunctions.getFieldStatusBackgroundColor(
        fieldStatus,
      ),
      child: Text(
        HelperFunctions.getFieldText(fieldStatus),
        style: AppTextStyle.bodyXs(
          color: HelperFunctions.geFieldStatusColor(fieldStatus),
        ),
      ),
    );
  }
}
