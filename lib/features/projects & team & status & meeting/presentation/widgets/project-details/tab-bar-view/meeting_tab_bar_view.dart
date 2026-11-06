import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/meeting_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/create_elevated_button.dart';
import 'package:two_dashboard/core/widgets/dialog/project/create_meeting_dialog.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';

class MeetingTabBarView extends StatefulWidget {
  const MeetingTabBarView({super.key, required this.projectId});
  final int projectId;

  @override
  State<MeetingTabBarView> createState() => _MeetingTabBarViewState();
}

class _MeetingTabBarViewState extends State<MeetingTabBarView> {
  @override
  void didChangeDependencies() {
    context.read<ProjectStatusTeamMeetingBloc>().add(
      ShowProjectMeetingsEvent(projectId: widget.projectId),
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
                    MeetingBlocStateHandling().createMeeting(
                      state,
                      context,
                      widget.projectId,
                    );
                  },
                  listenWhen:
                      (previous, current) =>
                          previous.createMeetingStatus !=
                          current.createMeetingStatus,
                  child: CreateElevatedButton(
                    addingType: "Meeting",
                    onPressed:
                        () => createMeetingDialog(context, widget.projectId),
                  ),
                ),
              ],
            ),
            PaddingConfig.h32,
            BlocConsumer<
              ProjectStatusTeamMeetingBloc,
              ProjectStatusTeamMeetingState
            >(
              listenWhen:
                  (previous, current) =>
                      (previous.deleteMeetingStatus !=
                              current.deleteMeetingStatus ||
                          previous.updateMeetingStatus !=
                              current.updateMeetingStatus),
              listener: (context, state) {
                MeetingBlocStateHandling().deleteMeeting(state, context);
                MeetingBlocStateHandling().updateMeeting(state, context);
              },
              buildWhen:
                  (previous, current) =>
                      previous.projectMeetingListStatus !=
                      current.projectMeetingListStatus,
              builder:
                  (context, state) =>
                      MeetingBlocStateHandling().getProjectMeetingList(state),
            ),
            PaddingConfig.h48,
          ],
        ),
      ),
    );
  }
}
