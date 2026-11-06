import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/device_utility.dart';
import 'package:two_dashboard/core/widgets/images/fetch_network_image.dart';
import 'package:two_dashboard/features/profile/domain/entities/employee_entity.dart';

class UserHeaderInfo extends StatelessWidget {
  const UserHeaderInfo({super.key, required this.employeeEntity});
  final EmployeeEntity employeeEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // image
            FetchNetworkImage(
              height: 50,
              width: 50,
              shape: BoxShape.circle,
              imagePath: employeeEntity.image,
              firstLetter: employeeEntity.name.split("").first,
            ),
          ],
        ),
        PaddingConfig.w8,
        // Name and Email
        if (!DeviceUtility.isMobileScreen(context))
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                employeeEntity.name,
                style: AppTextStyle.bodyMd(color: AppColors.fontDarkGray),
              ),
              Text(
                employeeEntity.role,
                style: AppTextStyle.bodySm(color: AppColors.fontLightGray),
              ),
            ],
          ),
      ],
    );
  }
}
