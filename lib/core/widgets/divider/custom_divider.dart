import 'package:flutter/material.dart';

import '../../../config/theme/color.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: AppColors.gray, thickness: 0.7);
  }
}
