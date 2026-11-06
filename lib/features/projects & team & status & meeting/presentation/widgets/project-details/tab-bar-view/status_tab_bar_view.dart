import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/status_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/create_elevated_button.dart';
import 'package:two_dashboard/core/widgets/dialog/project/create_project_status_dialog.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';

class StatusTabBarView extends StatefulWidget {
  const StatusTabBarView({super.key, required this.projectId});
  final int projectId;

  @override
  State<StatusTabBarView> createState() => _StatusTabBarViewState();
}

class _StatusTabBarViewState extends State<StatusTabBarView> {
  @override
  void didChangeDependencies() {
    context.read<ProjectStatusTeamMeetingBloc>().add(
      ShowProjectStatusEvent(projectId: widget.projectId),
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
                CreateElevatedButton(
                  addingType: "New Status",
                  onPressed:
                      () => craeteProjectStatusDialog(
                        context,
                        TextEditingController(),
                        widget.projectId,
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
                      previous.deleteStatus != current.deleteStatus,
              listener: (context, state) {
                StatusBlocStateHandling().deleteStatusListener(
                  state,
                  context,
                  widget.projectId,
                );
              },
              buildWhen:
                  (previous, current) =>
                      previous.showStatus != current.showStatus,
              builder: (context, state) {
                return StatusBlocStateHandling().getProjectStatusList(
                  state,
                  widget.projectId,
                );
              },
            ),
            PaddingConfig.h48,
          ],
        ),
      ),
    );
  }
}
