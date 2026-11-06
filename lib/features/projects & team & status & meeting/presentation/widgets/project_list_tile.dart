import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/core/widgets/images/group_of_image_circle.dart';

import '../../../../config/constants/sizes_config.dart';
import '../../../../config/theme/color.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/functions/device_utility.dart';
import '../../../../core/network/enums.dart';
import '../../../../core/widgets/container/status-containers/priority_container.dart';
import 'comments_box.dart';
import 'custom_progress_bar.dart';

class ProjectListTile extends StatelessWidget {
  const ProjectListTile({super.key, required this.colorStatus});
  final Color colorStatus;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.grayshade1,
          borderRadius: BorderRadius.circular(SizesConfig.borderRadiusXl),
        ),
        padding: EdgeInsets.all(24.0),
        child: Wrap(
          spacing: 24.0,
          runSpacing: 16.0,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            // Task title and date
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Marking Mobile UI Design', style: AppTextStyle.bodyLg()),
                Text(
                  'September 8, 2025',
                  style: AppTextStyle.bodySm(color: AppColors.fontLightGray),
                ),
              ],
            ),

            PriorityContainer(priority: TaskPriority.medium),
            CustomProgressBar(
              value: 50,
              lintWidth:
                  DeviceUtility.isMobileScreen(context)
                      ? DeviceUtility.getScreenWidth(context) * 0.4
                      : DeviceUtility.getScreenWidth(context) * 0.6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommentsBox(),
                PaddingConfig.w32,
                SizedBox(
                  width: 100,
                  child: GroupOfImageCircle(
                    imagePaths: ["", "", "", "", "", ""],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
