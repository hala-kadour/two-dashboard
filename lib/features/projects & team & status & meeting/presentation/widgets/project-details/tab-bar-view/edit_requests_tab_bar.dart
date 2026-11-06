import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/project_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/sent_edit_project_request_elevated_button.dart';
import 'package:two_dashboard/core/widgets/dialog/project/sent_edit_project_message_dialog.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';

class EditRequestsTabBar extends StatefulWidget {
  const EditRequestsTabBar({super.key, required this.projectId});
  final int projectId;

  @override
  State<EditRequestsTabBar> createState() => _EditRequestsTabBarState();
}

class _EditRequestsTabBarState extends State<EditRequestsTabBar> {
  @override
  void didChangeDependencies() {
    context.read<ProjectStatusTeamMeetingBloc>().add(
      ShowEditProjectRequestEvent(projectId: widget.projectId),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocListener<
                  ProjectStatusTeamMeetingBloc,
                  ProjectStatusTeamMeetingState
                >(
                  listener: (context, state) {
                    ProjectBlocStateHandling().sentEditProjectMessage(
                      state,
                      context,
                    );
                  },
                  listenWhen:
                      (previous, current) =>
                          previous.projectManagerSentEditProjectRequest !=
                          current.projectManagerSentEditProjectRequest,
                  child: SentEditProjectRequestElevatedButton(
                    onPressed:
                        () => sentEditProjectMessageDialog(
                          context,
                          widget.projectId,
                        ),
                  ),
                ),
              ],
            ),
            PaddingConfig.h32,
            BlocBuilder<
              ProjectStatusTeamMeetingBloc,
              ProjectStatusTeamMeetingState
            >(
              buildWhen:
                  (previous, current) =>
                      previous.editProjectRequestsListStatus !=
                      current.editProjectRequestsListStatus,
              builder:
                  (context, state) => ProjectBlocStateHandling()
                      .showEditProjectRequestList(state),
            ),
            PaddingConfig.h48,
          ],
        ),
      ),
    );
  }
}
