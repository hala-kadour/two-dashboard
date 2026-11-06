import 'package:flutter/material.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';

class CircleContainerForLeftCount extends StatelessWidget {
  const CircleContainerForLeftCount({
    super.key,
    required this.count,
    this.width,
    this.height,
  });
  final int count;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 40,
      height: height ?? 40,
      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.black),
      child: Center(
        child: Text(
          "+$count",
          style: AppTextStyle.bodyXs(color: AppColors.white),
        ),
      ),
    );
  }
}
