import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/cancel_text_button.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/save_text_button.dart';
import 'package:two_dashboard/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';

Future<dynamic> sentEditProjectMessageDialog(
  BuildContext context,
  int projectId,
) {
  final messageController = TextEditingController();
  return showDialog(
    context: context,
    builder:
        (context) => SizedBox(
          height: 100,
          child: AlertDialog(
            title: Text(
              TextStrings.sentEditMessage,
              style: AppTextStyle.bodyLg(),
            ),
            content: SizedBox(
              width: SizesConfig.dialogWidthXl,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFormField(
                    labelText: TextStrings.message,
                    maxLines: 3,
                    controller: messageController,
                    validator: (p0) {
                      if (p0 == null) {
                        return TextStrings.fieldValidation;
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              const CancelTextButton(),
              SaveTextButton(
                onPressed: () {
                  context.read<ProjectStatusTeamMeetingBloc>().add(
                    ProjectManagerSentEditProjectRequestEvent(
                      projectId: projectId,
                      message: messageController.text,
                    ),
                  );
                  context.pop();
                },
              ),
            ],
          ),
        ),
  );
}
