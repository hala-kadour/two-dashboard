import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';

class AddIconButton extends StatelessWidget {
  const AddIconButton({super.key, required this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        shape: CircleBorder(side: BorderSide(color: AppColors.gray)),
      ),
      onPressed: onPressed,
      icon: const Icon(
        Iconsax.add,
        size: SizesConfig.iconsSm,
        color: AppColors.rockShade2,
      ),
    );
  }
}
