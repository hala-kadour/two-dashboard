import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../config/constants/padding_config.dart';
import '../../../../config/constants/sizes_config.dart';
import '../../../../config/theme/color.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/widgets/container/custom_rounder_container.dart';

class TimeField extends StatelessWidget {
  const TimeField({
    super.key,
    required this.label,
    this.time,
    required this.onTap,
  });

  final String label;
  final TimeOfDay? time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasTime = time != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.bodySm()),
        PaddingConfig.h8,
        GestureDetector(
          onTap: onTap,
          child: CustomRounderContainer(
            borderColor: AppColors.grayShade2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hasTime ? time!.format(context) : label,
                  style: AppTextStyle.bodySm(
                    color: hasTime ? AppColors.black : AppColors.fontLightGray,
                  ),
                ),
                const Icon(Iconsax.clock, size: SizesConfig.iconsSm),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
