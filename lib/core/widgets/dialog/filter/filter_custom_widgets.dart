import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';

class FilterOption extends StatelessWidget {
  const FilterOption({
    super.key,
    required this.option,
    required this.valueNotifier,
    this.isOposite = false,
  });
  final String option;
  final ValueNotifier<bool> valueNotifier;
  final bool isOposite;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        valueNotifier.value = !valueNotifier.value;
      },
      child: ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder:
            (context, value, child) => Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizesConfig.borderRadiusXs),
                border: Border.all(color: AppColors.blueShade1),
                color:
                    (isOposite)
                        ? !(value)
                            ? AppColors.blueShade1
                            : Colors.transparent
                        : (value)
                        ? AppColors.blueShade1
                        : Colors.transparent,
              ),
              child: Row(
                children: [
                  if (isOposite && !value || !isOposite && value)
                    Icon(Icons.check, color: AppColors.blueShade2),
                  if (isOposite && !value || !isOposite && value)
                    PaddingConfig.w8,
                  Text(
                    option,
                    style: AppTextStyle.bodySm(
                      color:
                          (isOposite)
                              ? !(value)
                                  ? AppColors.blueShade2
                                  : AppColors.blueShade1
                              : (value)
                              ? AppColors.blueShade2
                              : AppColors.blueShade1,
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}

class FilterOptionTitle extends StatelessWidget {
  const FilterOptionTitle({
    super.key,
    required this.title,
    required this.iconData,
  });
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData, size: SizesConfig.iconsMd, color: AppColors.greenShade2),
        PaddingConfig.w8,
        Text(
          "$title :",
          style: AppTextStyle.bodySm(color: AppColors.greenShade2),
        ),
      ],
    );
  }
}

class FilterByText extends StatelessWidget {
  const FilterByText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(TextStrings.filterBy, style: AppTextStyle.bodyLg());
  }
}
