import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/dialog/sprint/complete_sprint_dialog.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/project_sprint.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/sprint_entity.dart';

class CompleteSprintOutLineButton extends StatelessWidget {
  const CompleteSprintOutLineButton({super.key, required this.sprint});

  final SprintEntity sprint;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.grayShade2, width: 0.7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(SizesConfig.buttonRadius),
        ),
      ),
      onPressed: () {
        final sprints = getCachedSprintForProject(sprint.projectId);
        showCompleteSprintDialog(context, sprint: sprint, sprints: sprints);
      },
      child: Text(
        TextStrings.completeSprint,
        style: AppTextStyle.buttonStyle(),
      ),
    );
  }
}
