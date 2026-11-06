import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/config/theme/theme_cubit.dart';
import 'package:two_dashboard/core/widgets/dropdown-list/custom_dropdown_list.dart';

// ignore: must_be_immutable
class GeneralInfoRow extends StatefulWidget {
  GeneralInfoRow({
    super.key,
    required this.title,
    required this.value,
    required this.isLang,
  });
  final String title;
  String value;
  final bool isLang;

  @override
  State<GeneralInfoRow> createState() => _GeneralInfoRowState();
}

class _GeneralInfoRowState extends State<GeneralInfoRow> {
  List<String> lanList = ["Arabic", "English"];
  List<String> themeList = ["Dark", "Light"];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: AppTextStyle.bodyLg(color: AppColors.greenShade2),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizesConfig.borderRadiusMd),
              border: Border.all(color: AppColors.gray, width: 1),
            ),
            child: CustomDropdownList(
              selectYour: "",
              width: 325,
              value: widget.value,
              color: Colors.transparent,
              items:
                  widget.isLang
                      ? lanList.map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList()
                      : themeList.map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList(),
              onChanged: (value) {
                setState(() {
                  widget.value = value!;
                  if (!widget.isLang) {
                    context.read<ThemeCubit>().toggleTheme(value);
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
