import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';

import '../../../../config/theme/color.dart';
import '../../../../config/theme/text_style.dart';

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({
    super.key,
    required this.lintWidth,
    required this.value,
  });
  final double lintWidth;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: lintWidth,
          child: LinearProgressIndicator(
            value: value / 100,
            trackGap: 2,
            backgroundColor: AppColors.greenShade1,
            color: AppColors.greenShade2,
            minHeight: 8.0,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        PaddingConfig.w8,
        Text(
          '%$value',
          style: AppTextStyle.bodySm(color: AppColors.fontLightGray),
        ),
      ],
    );
  }
}
