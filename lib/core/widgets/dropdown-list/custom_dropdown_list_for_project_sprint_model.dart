import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/project_sprint.dart';

class CustomDropdownListForProjectSprintModel extends StatelessWidget {
  const CustomDropdownListForProjectSprintModel({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });
  final ProjectSprint? value;
  final List<DropdownMenuItem<ProjectSprint>>? items;
  final void Function(ProjectSprint?)? onChanged;

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
        border: Border.all(color: AppColors.black, width: 0.7),
      ),
      child: DropdownButton<ProjectSprint>(
        borderRadius: BorderRadius.circular(SizesConfig.md),
        isExpanded: true,
        value: value,
        underline: const SizedBox(),
        focusColor: AppColors.white,
        icon: const Icon(Icons.keyboard_arrow_down_sharp),
        elevation: 0,
        hint: Text(
          "select your sprint",
          style: AppTextStyle.bodySm(color: AppColors.fontDarkGray),
        ),
        style: AppTextStyle.bodySm(color: AppColors.fontDarkGray),
        dropdownColor: AppColors.white,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
