import 'package:flutter/material.dart';
import 'package:two_dashboard/config/theme/color.dart';

class CustomCircularContainer extends StatelessWidget {
  const CustomCircularContainer({
    super.key,
    this.child,
    this.margin,
    this.padding,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.showBorder = false,
    this.baskgroundColor = AppColors.white,
    this.borderColor = AppColors.gray,
  });
  final Widget? child;
  final double? width;
  final double? height;
  final double radius;
  final bool showBorder;
  final Color borderColor;
  final Color baskgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: baskgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
    );
  }
}
