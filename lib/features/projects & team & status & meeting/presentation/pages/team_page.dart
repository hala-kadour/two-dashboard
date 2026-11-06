import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/animation/empty_status_animation.dart';
import 'package:two_dashboard/core/widgets/animation/error_status_animation.dart';
import 'package:two_dashboard/core/widgets/animation/loading_status_animation.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/create_elevated_button.dart';
import 'package:two_dashboard/core/widgets/layouts/templates/page_template.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/team_entity.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/widgets/custom_team_grid_view.dart';

import '../../../../config/constants/padding_config.dart';
import '../../../../config/routes/app_route_config.dart';
import '../../../../core/widgets/texts/page_title.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _SelectTeamPageState();
}

class _SelectTeamPageState extends State<TeamPage> {
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
            PageTitle(pageTitle: "Teams"),
            PaddingConfig.h32,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                  if (state.showTeams.isEmpty) {
                    return Center(child: EmptyStatusAnimation());
                  } else {
                    return CustomTeamGridView(
                      wantToChoose: false,
                      teamList: state.showTeams,
                      selectedTeam: selectedTeam,
                      onUpdate: (value) {},
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
