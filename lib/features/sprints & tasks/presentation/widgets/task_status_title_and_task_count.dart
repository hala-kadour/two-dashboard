import 'package:flutter/material.dart';

import '../../../../config/constants/sizes_config.dart';
import '../../../../config/theme/color.dart';
import '../../../../config/theme/text_style.dart';

class TaskStatusTitleAndTaskCount extends StatelessWidget {
  const TaskStatusTitleAndTaskCount({
    super.key,
    required this.title,
    required this.colorState,
    required this.count,
  });
  final String title;
  final Color colorState;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyle.bodySm(color: colorState)),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizesConfig.sm,
            vertical: 2.0,
          ),
          decoration: BoxDecoration(
            color: colorState,
            borderRadius: BorderRadius.circular(SizesConfig.borderRadiusXs),
          ),
          child: Text(
            count,
            style: AppTextStyle.bodySm(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
