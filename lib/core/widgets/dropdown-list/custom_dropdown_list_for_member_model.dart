import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/team.dart';

class CustomDropdownListForMemberModel extends StatelessWidget {
  const CustomDropdownListForMemberModel({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });
  final Member? value;
  final List<DropdownMenuItem<Member>>? items;
  final void Function(Member?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: SizesConfig.sm,
        horizontal: SizesConfig.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(SizesConfig.borderRadiusMd),
        border: Border.all(color: AppColors.gray, width: 0.7),
      ),
      child: DropdownButton<Member>(
        borderRadius: BorderRadius.circular(SizesConfig.md),
        isExpanded: true,
        value: value,
        underline: const SizedBox(),
        focusColor: AppColors.white,
        icon: const Icon(Icons.keyboard_arrow_down_sharp),
        elevation: 0,
        hint: Text(
          "select your Role",
          style: AppTextStyle.bodySm(color: AppColors.fontLightGray),
        ),
        style: AppTextStyle.bodySm(color: AppColors.fontLightGray),
        dropdownColor: AppColors.white,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
