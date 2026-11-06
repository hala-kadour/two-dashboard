import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/animation/error_status_animation.dart';
import 'package:two_dashboard/core/widgets/animation/loading_status_animation.dart';
import 'package:two_dashboard/core/widgets/animation/unauthorized_status_animation.dart';
import 'package:two_dashboard/core/widgets/dialog/status/error_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/loading_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/not_authorized_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/success_dialog.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/widgets/project-details/meeting_card.dart';

class MeetingBlocStateHandling {
  // Create Meeting
  void createMeeting(
    ProjectStatusTeamMeetingState state,
    BuildContext context,
    int projectId,
  ) {
    if (state.createMeetingStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.createMeetingStatus == CasualStatus.success) {
      context.pop();
      context.read<ProjectStatusTeamMeetingBloc>().add(
        ShowProjectMeetingsEvent(projectId: projectId),
      );
      showSuccessDialog(context, () {
        context.pop();
      });
      context.pop();
    } else if (state.createMeetingStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.createMeetingStatus == CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  // Update Meeting
  void updateMeeting(
    ProjectStatusTeamMeetingState state,
    BuildContext context,
  ) {
    if (state.updateMeetingStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.updateMeetingStatus == CasualStatus.success) {
      context.pop();
      showSuccessDialog(context, () {
        context.pop();
      });
      context.pop();
    } else if (state.updateMeetingStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.updateMeetingStatus == CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  // Delete Meeting
  void deleteMeeting(
    ProjectStatusTeamMeetingState state,
    BuildContext context,
  ) {
    if (state.deleteMeetingStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.deleteMeetingStatus == CasualStatus.success) {
      context.pop();
      showSuccessDialog(context, () {
        context.pop();
      });
      context.pop();
    } else if (state.deleteMeetingStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.deleteMeetingStatus == CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  // get project Meeting List
  Widget getProjectMeetingList(ProjectStatusTeamMeetingState state) {
    if (state.projectMeetingListStatus == CasualStatus.loading) {
      return Center(child: const LoadingStatusAnimation());
    } else if (state.projectMeetingListStatus == CasualStatus.success) {
      return SizedBox(
        height: 600,
        child: ListView.builder(
          itemCount: state.projectMeetingList.length,
          itemBuilder:
              (context, index) =>
                  MeetingCard(meetingModel: state.projectMeetingList[index]),
        ),
      );
    } else if (state.projectMeetingListStatus == CasualStatus.failure) {
      return Center(child: ErrorStatusAnimation(errorMessage: state.message));
    } else if (state.projectMeetingListStatus == CasualStatus.not_authorized) {
      return Center(child: UnauthorizedStatusAnimation());
    } else {
      return const SizedBox();
    }
  }
}
