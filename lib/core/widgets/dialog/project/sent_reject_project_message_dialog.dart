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

Future<dynamic> sentRejectProjectMessageDialog(
  BuildContext context,
  int projectId,
  TextEditingController messageController,
) {
  final formKey = GlobalKey<FormState>();
  return showDialog(
    context: context,
    builder:
        (context) => SizedBox(
          height: 100,
          child: AlertDialog(
            title: Text(
              TextStrings.sentRejectMessage,
              style: AppTextStyle.bodyLg(),
            ),
            content: SizedBox(
              width: SizesConfig.dialogWidthXl,
              child: Form(
                key: formKey,
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
            ),
            actions: [
              const CancelTextButton(),
              SaveTextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<ProjectStatusTeamMeetingBloc>().add(
                      ProjectManagerRejectProjectEvent(
                        projectId: projectId,
                        message: messageController.text,
                      ),
                    );
                    context.pop();
                  }
                },
              ),
            ],
          ),
        ),
  );
}
