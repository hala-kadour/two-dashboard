// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';

// ignore: must_be_immutable
class VisibilityButton extends StatelessWidget {
  VisibilityButton({super.key, required this.onPressed, required this.isdown});
  final void Function()? onPressed;
  bool isdown;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        !isdown ? Iconsax.arrow_down_1 : Iconsax.arrow_up_2,
        color: AppColors.white,
        size: SizesConfig.iconsSm,
      ),
    );
  }
}
