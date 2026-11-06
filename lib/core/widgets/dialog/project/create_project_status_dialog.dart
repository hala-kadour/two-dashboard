import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/status_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/cancel_text_button.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/save_text_button.dart';
import 'package:two_dashboard/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';

Future<dynamic> craeteProjectStatusDialog(
  BuildContext context,
  TextEditingController controller,
  int projectId,
) {
  return showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text(
            "Create Task Status For The Project:",
            style: AppTextStyle.bodyLg(),
          ),
          content: CustomTextFormField(
            labelText: "Status",
            controller: controller,
            validator: (p0) {
              if (p0 == null) {
                return "Add Text";
              }
              return null;
            },
          ),
          actions: [
            const CancelTextButton(),
            BlocListener<
              ProjectStatusTeamMeetingBloc,
              ProjectStatusTeamMeetingState
            >(
              listenWhen:
                  (previous, current) =>
                      previous.createStatus != current.createStatus,
              listener: (context, state) {
                StatusBlocStateHandling().createStatusListener(
                  state,
                  context,
                  projectId,
                );
              },
              child: SaveTextButton(
                onPressed: () {
                  context.read<ProjectStatusTeamMeetingBloc>().add(
                    CreateStatusEvent(
                      projectId: projectId,
                      statusName: controller.text,
                    ),
                  );
                  context.pop();
                },
              ),
            ),
          ],
        ),
  );
}
