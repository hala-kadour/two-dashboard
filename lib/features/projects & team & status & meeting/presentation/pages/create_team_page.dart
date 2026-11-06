import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/team_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/breadcrumbs/breadcumbs_item.dart';
import 'package:two_dashboard/core/widgets/divider/custom_page_divider.dart';
import 'package:two_dashboard/core/widgets/layouts/templates/page_template.dart';
import 'package:two_dashboard/core/widgets/texts/page_title.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/widgets/create_team_form.dart';

import '../../../../config/constants/padding_config.dart';
import '../../../../config/routes/app_route_config.dart';
import '../../../../core/widgets/buttons/icon-buttons/back_button.dart';

class CreateTeamPage extends StatefulWidget {
  const CreateTeamPage({super.key});

  @override
  State<CreateTeamPage> createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<CreateTeamPage> {
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
                  AppRouteConfig.selectTeam,
                  AppRouteConfig.createTeam,
                ],
                pages: ["All Project", "Select Team", "Create Team"],
              ),
              PaddingConfig.h16,
              Row(
                children: [
                  const CustomBackButton(),
                  PaddingConfig.w8,
                  PageTitle(pageTitle: "Create Team"),
                ],
              ),
              CustomPageDivider(),
              PaddingConfig.h16,
              BlocListener<
                ProjectStatusTeamMeetingBloc,
                ProjectStatusTeamMeetingState
              >(
                listener: (context, state) {
                  TeamBlocStateHandling().createTeam(state, context);
                },
                listenWhen:
                    (previous, current) =>
                        previous.createTeamStatus != current.createTeamStatus,
                child: CreateTeamForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
