import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../config/constants/padding_config.dart';
import '../../../../config/constants/sizes_config.dart';
import '../../../../config/theme/color.dart';
import '../../../../config/theme/text_style.dart';

class CommentsBox extends StatelessWidget {
  const CommentsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizesConfig.borderRadiusSm),
        color: AppColors.white,
      ),
      child: Row(
        children: [
          Icon(
            Iconsax.messages_1,
            size: SizesConfig.iconsMd,
            color: AppColors.fontLightGray,
          ),
          PaddingConfig.w8,
          Text("5", style: AppTextStyle.bodyMd(color: AppColors.fontLightGray)),
        ],
      ),
    );
  }
}
