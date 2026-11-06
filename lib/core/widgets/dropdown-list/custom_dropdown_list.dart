import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';

class CustomDropdownList extends StatelessWidget {
  const CustomDropdownList({
    super.key,
    required this.selectYour,
    required this.value,
    required this.items,
    required this.onChanged,
    this.color,
    this.width,
  });
  final String selectYour;
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  final Color? color;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: SizesConfig.sm,
        horizontal: SizesConfig.md,
      ),
      decoration: BoxDecoration(
        color: color ?? AppColors.fieldColor,
        borderRadius: BorderRadius.circular(SizesConfig.borderRadiusMd),
      ),
      child: DropdownButton<String>(
        borderRadius: BorderRadius.circular(SizesConfig.md),
        isExpanded: true,
        value: value,
        underline: const SizedBox(),
        focusColor: AppColors.white,
        icon: const Icon(Icons.keyboard_arrow_down_sharp),
        elevation: 0,
        hint: Text(
          "select your $selectYour",
          style: AppTextStyle.bodySm(color: AppColors.fontLightGray),
        ),
        style: AppTextStyle.bodySm(color: AppColors.fontLightGray),
        dropdownColor: AppColors.fieldColor,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
