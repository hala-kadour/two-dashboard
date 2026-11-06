import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/project_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/texts/page_title.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';

class AssignRequestsPage extends StatefulWidget {
  const AssignRequestsPage({super.key});

  @override
  State<AssignRequestsPage> createState() => _AssignRequestsPageState();
}

class _AssignRequestsPageState extends State<AssignRequestsPage> {
  @override
  void didChangeDependencies() {
    context.read<ProjectStatusTeamMeetingBloc>().add(
      ShowProjectAssignRequestListEvent(),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: SizesConfig.lg,
          left: SizesConfig.lg,
          right: SizesConfig.lg,
        ),
        child: Column(
          children: [
            PageTitle(pageTitle: TextStrings.assignRequests),
            PaddingConfig.h32,
            BlocListener<
              ProjectStatusTeamMeetingBloc,
              ProjectStatusTeamMeetingState
            >(
              listenWhen:
                  (previous, current) =>
                      (previous.projectManagerRejectProjectStatus !=
                          current.projectManagerRejectProjectStatus) ||
                      (previous.projectManagerAcceptProjectStatus !=
                          current.projectManagerAcceptProjectStatus),
              listener: (context, state) {
                ProjectBlocStateHandling().projectManagerRejectProject(
                  state,
                  context,
                );
                ProjectBlocStateHandling().projectManagerAcceptProject(
                  state,
                  context,
                );
              },
              child: Flexible(
                child: BlocBuilder<
                  ProjectStatusTeamMeetingBloc,
                  ProjectStatusTeamMeetingState
                >(
                  buildWhen:
                      (previous, current) =>
                          (previous.projectAssignRequestListStatus !=
                              current.projectAssignRequestListStatus),
                  builder: (context, state) {
                    return ProjectBlocStateHandling()
                        .getAssignProjectsRequestTable(state);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
