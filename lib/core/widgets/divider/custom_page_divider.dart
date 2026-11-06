import 'package:flutter/material.dart';
import 'package:two_dashboard/config/theme/color.dart';

class CustomPageDivider extends StatelessWidget {
  const CustomPageDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Divider(color: AppColors.grayShade2, thickness: 0.8),
    );
  }
}
