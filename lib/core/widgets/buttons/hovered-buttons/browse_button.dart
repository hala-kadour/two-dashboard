import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';

// ignore: must_be_immutable
class BrowseButton extends StatelessWidget {
  BrowseButton({super.key, required this.onTap});
  ValueNotifier<bool> isHover = ValueNotifier(false);

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (context) {
        isHover.value = true;
      },
      onExit: (context) {
        isHover.value = false;
      },
      child: ValueListenableBuilder(
        valueListenable: isHover,
        builder:
            (context, value, child) => InkWell(
              onTap: onTap,
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: SizesConfig.animationDuration,
                ),
                width: 75,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.gray, width: 1.1),
                  color: value ? AppColors.blueShade2 : AppColors.blueShade1,
                  borderRadius: BorderRadius.circular(SizesConfig.buttonRadius),
                ),
                child: Text(
                  TextStrings.browse,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.buttonStyle(
                    color: value ? AppColors.white : AppColors.blueShade2,
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
