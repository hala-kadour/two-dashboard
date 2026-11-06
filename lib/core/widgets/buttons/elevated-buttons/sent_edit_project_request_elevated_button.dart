import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';

class SentEditProjectRequestElevatedButton extends StatelessWidget {
  const SentEditProjectRequestElevatedButton({
    super.key,
    required this.onPressed,
  });
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          backgroundColor: AppColors.blueShade2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizesConfig.buttonRadius),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            const Icon(Iconsax.send_2, color: AppColors.white),
            PaddingConfig.w8,
            Text(
              "Sent Edit Request",
              style: AppTextStyle.buttonStyle(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
