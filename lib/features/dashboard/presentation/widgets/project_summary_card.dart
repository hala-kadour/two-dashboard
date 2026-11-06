import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../config/constants/padding_config.dart';
import '../../../../config/constants/sizes_config.dart';
import '../../../../config/theme/color.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/widgets/buttons/elevated-buttons/create_elevated_button.dart';

class ProjectSummaryCard extends StatelessWidget {
  const ProjectSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(SizesConfig.borderRadiusMd),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Project Summary", style: AppTextStyle.bodyLg()),
                  Text(
                    "add new project and manage all",
                    style: AppTextStyle.bodySm(color: AppColors.fontLightGray),
                  ),
                ],
              ),
              CreateElevatedButton(addingType: "Project", onPressed: () {}),
            ],
          ),
          PaddingConfig.h16,
          Row(
            children: [
              _summaryBox(
                'Upcoming',
                '32',
                AppColors.yellowShade1,
                Iconsax.layer,
              ),
              const SizedBox(width: 12),
              _summaryBox(
                'In Progress',
                '64',
                AppColors.blueShade1,
                Iconsax.status_up,
              ),
              const SizedBox(width: 12),
              _summaryBox(
                'Completed',
                '105',
                AppColors.greenShade1,
                Iconsax.tick_square,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryBox(String label, String count, Color color, IconData icon) {
    return Container(
      width: 160,
      height: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.white,
            child: Icon(icon, size: 28),
          ),
          const Spacer(),
          Text(
            count,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(label, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}
