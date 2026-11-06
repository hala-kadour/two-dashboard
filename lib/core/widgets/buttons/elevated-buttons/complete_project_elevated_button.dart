import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';

class CompleteProjectElevatedButton extends StatelessWidget {
  const CompleteProjectElevatedButton({super.key, required this.projectId});
  final int projectId;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        backgroundColor: AppColors.greenShade2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizesConfig.buttonRadius),
        ),
      ),
      onPressed: () {
        context.read<ProjectStatusTeamMeetingBloc>().add(
          ProjectManagerCompleteProjectEvent(projectId: projectId),
        );
      },
      child: Row(
        children: [
          const Icon(Iconsax.flash, color: AppColors.white),
          PaddingConfig.w8,
          Text(
            TextStrings.completeProject,
            style: AppTextStyle.buttonStyle(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
