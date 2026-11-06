import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/strings/assets_path.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/sprint_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/complete_sprint_elevated_button.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/cancel_text_button.dart';
import 'package:two_dashboard/core/widgets/dropdown-list/sprint_selection_dropdowm_list.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/project_sprint.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/sprint_entity.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/bloc/sprint_and_task_bloc.dart';

void showCompleteSprintDialog(
  BuildContext context, {
  required SprintEntity sprint,
  required List<ProjectSprint> sprints,
}) {
  Map<String, dynamic>? selectedAction;

  showDialog(
    context: context,
    builder: (context) {
      sprints.addAll([
        ProjectSprint(id: 999, name: "New Sprint", projectId: 999),
        ProjectSprint(id: 888, name: "Backlog", projectId: 888),
      ]);
      return AlertDialog(
        insetPadding: EdgeInsets.all(0),
        title: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(16.0),
          child: Image.asset(ImagesPath.background, fit: BoxFit.cover),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Complete ${sprint.label}', style: AppTextStyle.headerSm()),
            PaddingConfig.h16,
            if (sprint.incompleteTasksCount > 0)
              Text(
                "⚠️ This sprint contains ${sprint.incompleteTasksCount} open work items.",
                style: AppTextStyle.bodyLg(color: AppColors.redShade2),
              ),
            PaddingConfig.h16,
            SprintSelectionDropdown(
              cachedSprints: sprints,
              openTasksCount: sprint.incompleteTasksCount,
              onActionSelected: (data) {
                selectedAction = data;
              },
            ),
          ],
        ),
        actions: [
          CancelTextButton(),
          BlocListener<SprintAndTaskBloc, SprintAndTaskState>(
            listenWhen:
                (previous, current) =>
                    previous.completeSprintStatus !=
                    current.completeSprintStatus,
            listener:
                (context, state) => SprintBlocStateHandling()
                    .completeSprintListener(state, context, sprint.projectId),
            child: CompleteSprintElevatedButton(
              onPressed: () {
                if (selectedAction != null ||
                    sprint.incompleteTasksCount == 0) {
                  final actionData = selectedAction ?? {'action': 'auto'};
                  print(actionData);
                  // بناء الحدث حسب البيانات المختارة
                  context.read<SprintAndTaskBloc>().add(
                    CompleteSprintEvent(
                      projectId: sprint.projectId,
                      sprintId: sprint.id,
                      action: actionData['action'],
                      newSprintLabel: actionData['new_sprint_label'],
                      existingSprintId: actionData['existing_sprint_id'],
                    ),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("يرجى تحديد أين تنقل المهام المفتوحة"),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      );
    },
  );
}
