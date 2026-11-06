import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';

// ignore: must_be_immutable
class AddSomthingButton extends StatelessWidget {
  AddSomthingButton({super.key, required this.onTap, required this.something});

  final void Function()? onTap;
  final String something;
  ValueNotifier<bool> isHover = ValueNotifier(false);

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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: value ? AppColors.greenShade2 : Colors.transparent,
                  border: Border.all(color: AppColors.greenShade2, width: 1.1),
                  borderRadius: BorderRadius.circular(SizesConfig.buttonRadius),
                ),
                child: Text(
                  something,
                  style: AppTextStyle.buttonStyle(
                    color: value ? AppColors.white : AppColors.greenShade2,
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
