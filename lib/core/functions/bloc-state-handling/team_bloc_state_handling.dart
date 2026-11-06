import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/dialog/status/error_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/loading_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/not_authorized_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/success_dialog.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';

class TeamBlocStateHandling {
  // Create Team
  void createTeam(ProjectStatusTeamMeetingState state, BuildContext context) {
    if (state.createTeamStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.createTeamStatus == CasualStatus.success) {
      context.pop();
      context.read<ProjectStatusTeamMeetingBloc>().add(ShowTeamsEvent());
      showSuccessDialog(context, () {
        context.pop();
      });
    } else if (state.createTeamStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.createTeamStatus == CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  void updateTeam(ProjectStatusTeamMeetingState state, BuildContext context) {
    if (state.addMemersStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.addMemersStatus == CasualStatus.success) {
      context.pop();
      context.read<ProjectStatusTeamMeetingBloc>().add(ShowTeamsEvent());
      showSuccessDialog(context, () {
        context.pop();
      });
    } else if (state.addMemersStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.addMemersStatus == CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  // Add Team
  void addTeam(ProjectStatusTeamMeetingState state, BuildContext context) {
    if (state.addTeamStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.addTeamStatus == CasualStatus.success) {
      context.pop();
      context.read<ProjectStatusTeamMeetingBloc>().add(ShowAllProjectsEvent());
      showSuccessDialog(context, () {
        context.pushReplacementNamed(AppRouteConfig.projectRequests);
        context.pop();
      });
    } else if (state.addTeamStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.addMemersStatus == CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }
}
