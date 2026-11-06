import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, required this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.rockshade1, width: .4),
          borderRadius: BorderRadius.circular(SizesConfig.buttonRadius),
        ),
      ),
      tooltip: TextStrings.filter,
      onPressed: onPressed,
      icon: Icon(
        Iconsax.filter,
        size: SizesConfig.iconsSm,
        color: AppColors.rockShade2,
      ),
      // icon: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     const Icon(
      //       Iconsax.setting_4,
      //       size: SizesConfig.iconsSm,
      //       color: AppColors.rockShade2,
      //     ),
      //     PaddingConfig.w8,
      //     Text(
      //       TextStrings.filter,
      //       style: AppTextStyle.buttonStyle(color: AppColors.rockShade2),
      //     ),
      //   ],
      // ),
    );
  }
}
