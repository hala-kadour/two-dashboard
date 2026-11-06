import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';

class ChooseDateButton extends StatefulWidget {
  const ChooseDateButton({super.key});

  @override
  State<ChooseDateButton> createState() => _ChooseDateButtonState();
}

class _ChooseDateButtonState extends State<ChooseDateButton> {
  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    return IconButton(
      style: IconButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.rockshade1, width: .3),
          borderRadius: BorderRadius.circular(SizesConfig.borderRadiusXl),
        ),
      ),
      onPressed: () async {
        // Show the date picker
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null && pickedDate != selectedDate) {
          setState(() {
            selectedDate = pickedDate;
          });
        }
      },
      icon: Row(
        children: [
          const Icon(
            Iconsax.calendar_1,
            size: SizesConfig.iconsSm,
            color: AppColors.rockShade2,
          ),
          PaddingConfig.w8,
          Text(
            formattedDate,
            style: AppTextStyle.bodySm(color: AppColors.rockShade2),
          ),
        ],
      ),
    );
  }
}
