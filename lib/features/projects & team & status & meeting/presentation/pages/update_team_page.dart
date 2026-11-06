import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/team_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/breadcrumbs/breadcumbs_item.dart';
import 'package:two_dashboard/core/widgets/divider/custom_page_divider.dart';
import 'package:two_dashboard/core/widgets/layouts/templates/page_template.dart';
import 'package:two_dashboard/core/widgets/texts/page_title.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/team.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/widgets/update_team_form.dart';

import '../../../../config/constants/padding_config.dart';
import '../../../../config/routes/app_route_config.dart';
import '../../../../core/widgets/buttons/icon-buttons/back_button.dart';

class UpdateTeamPage extends StatefulWidget {
  const UpdateTeamPage({super.key, required this.team});
  final Team team;

  @override
  State<UpdateTeamPage> createState() => _UpdateTeamPageState();
}

class _UpdateTeamPageState extends State<UpdateTeamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTemplate(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Breadcrumbs(
                paths: [
                  AppRouteConfig.allProjects,
                  AppRouteConfig.projectDetails,
                  AppRouteConfig.updateTeam,
                ],
                pages: ["All Project", "Select Team", "Update Team"],
              ),
              PaddingConfig.h16,
              Row(
                children: [
                  const CustomBackButton(),
                  PaddingConfig.w8,
                  PageTitle(pageTitle: "Update Team"),
                ],
              ),
              CustomPageDivider(),
              PaddingConfig.h16,
              BlocListener<
                ProjectStatusTeamMeetingBloc,
                ProjectStatusTeamMeetingState
              >(
                listener: (context, state) {
                  TeamBlocStateHandling().updateTeam(state, context);
                },
                listenWhen:
                    (previous, current) =>
                        previous.addMemersStatus != current.addMemersStatus,
                child: EditTeamForm(team: widget.team),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
