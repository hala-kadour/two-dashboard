import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/team_bloc_state_handling.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/animation/empty_status_animation.dart';
import 'package:two_dashboard/core/widgets/animation/error_status_animation.dart';
import 'package:two_dashboard/core/widgets/animation/loading_status_animation.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/create_elevated_button.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/save_elevated_button.dart';
import 'package:two_dashboard/core/widgets/divider/custom_page_divider.dart';
import 'package:two_dashboard/core/widgets/layouts/templates/page_template.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/team_entity.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/widgets/custom_team_grid_view.dart';

import '../../../../config/constants/padding_config.dart';
import '../../../../config/routes/app_route_config.dart';
import '../../../../core/widgets/breadcrumbs/breadcumbs_item.dart';
import '../../../../core/widgets/buttons/icon-buttons/back_button.dart';
import '../../../../core/widgets/texts/page_title.dart';

class SelectTeamPage extends StatefulWidget {
  const SelectTeamPage({super.key, required this.projectId});
  final String projectId;

  @override
  State<SelectTeamPage> createState() => _SelectTeamPageState();
}

class _SelectTeamPageState extends State<SelectTeamPage> {
  ValueNotifier<TeamEntity?> selectedTeam = ValueNotifier(null);
  @override
  void didChangeDependencies() {
    context.read<ProjectStatusTeamMeetingBloc>().add(ShowTeamsEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Breadcrumbs(
              paths: [
                AppRouteConfig.projectRequests,
                AppRouteConfig.selectTeam,
              ],
              pages: ["Project Requests", "Select Team"],
            ),
            PaddingConfig.h16,
            Row(
              children: [
                const CustomBackButton(),
                PaddingConfig.w8,
                PageTitle(pageTitle: "Select Team"),
              ],
            ),
            CustomPageDivider(),
            PaddingConfig.h16,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocListener<
                  ProjectStatusTeamMeetingBloc,
                  ProjectStatusTeamMeetingState
                >(
                  listener: (context, state) {
                    TeamBlocStateHandling().addTeam(state, context);
                  },
                  listenWhen:
                      (previous, current) =>
                          previous.addTeamStatus != current.addTeamStatus,
                  child: SaveElevatedButton(
                    onPressed: () {
                      context.read<ProjectStatusTeamMeetingBloc>().add(
                        AddProjectTeamEvent(
                          projectId: int.parse(widget.projectId),
                          teamId: selectedTeam.value!.id,
                        ),
                      );
                    },
                  ),
                ),
                PaddingConfig.w16,
                CreateElevatedButton(
                  addingType: "New Team",
                  onPressed: () => context.pushNamed(AppRouteConfig.createTeam),
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
                      previous.showTeamsStatus != current.showTeamsStatus,
              builder: (context, state) {
                if (state.showTeamsStatus == CasualStatus.loading) {
                  return Center(child: LoadingStatusAnimation());
                } else if (state.showTeamsStatus == CasualStatus.success) {
                  print(state.showTeams[0].membersList);
                  if (state.showTeams.isEmpty) {
                    return Center(child: EmptyStatusAnimation());
                  } else {
                    //return Center(child: Text("Hi"));
                    return CustomTeamGridView(
                      wantToChoose: true,
                      teamList: state.showTeams,
                      selectedTeam: selectedTeam,
                      onUpdate: (value) {
                        selectedTeam.value = value;
                      },
                    );
                  }
                } else if (state.showTeamsStatus == CasualStatus.failure) {
                  return ErrorStatusAnimation(errorMessage: state.message);
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
