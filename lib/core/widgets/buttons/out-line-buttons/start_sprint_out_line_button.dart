import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/bloc/sprint_and_task_bloc.dart';

class StartSprintOutLineButton extends StatelessWidget {
  const StartSprintOutLineButton({
    super.key,
    required this.projectId,
    required this.sprintId,
  });

  final int projectId;
  final int sprintId;

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
        context.read<SprintAndTaskBloc>().add(
          StartSprintEvent(projectId: projectId, sprintId: sprintId),
        );
      },
      child: Text(TextStrings.startSprint, style: AppTextStyle.buttonStyle()),
    );
  }
}
