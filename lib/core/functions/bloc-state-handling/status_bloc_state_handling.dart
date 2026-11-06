import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/animation/empty_status_animation.dart';
import 'package:two_dashboard/core/widgets/animation/error_status_animation.dart';
import 'package:two_dashboard/core/widgets/dialog/status/error_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/loading_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/success_dialog.dart';
import 'package:two_dashboard/core/widgets/shimmers/card-loading/loading_status_card.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/project_status_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/widgets/board_kanban_view.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/widgets/status_kanban_view.dart';

class StatusBlocStateHandling {
  /// *** Listener Side *** ///
  /// Create Status
  void createStatusListener(
    ProjectStatusTeamMeetingState state,
    BuildContext context,
    int projectId,
  ) {
    if (state.createStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.createStatus == CasualStatus.success) {
      context.pop();
      context.read<ProjectStatusTeamMeetingBloc>().add(
        ShowProjectStatusEvent(projectId: projectId),
      );
    } else if (state.createStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    }
  }

  /// Update Status Order
  void updateStatusOrderListener(
    ProjectStatusTeamMeetingState state,
    BuildContext context,
    int projectId,
  ) {
    if (state.updateOrderStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.updateOrderStatus == CasualStatus.success) {
      context.pop();
      context.read<ProjectStatusTeamMeetingBloc>().add(
        ShowProjectStatusEvent(projectId: projectId),
      );
      showSuccessDialog(context, () {
        context.pop();
        context.pop();
      });
    } else if (state.updateOrderStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    }
  }

  /// Delete Status Order
  void deleteStatusListener(
    ProjectStatusTeamMeetingState state,
    BuildContext context,
    int projectId,
  ) {
    if (state.deleteStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.deleteStatus == CasualStatus.success) {
      context.pop();
      context.read<ProjectStatusTeamMeetingBloc>().add(
        ShowProjectStatusEvent(projectId: projectId),
      );
      showSuccessDialog(context, () {
        context.pop();
      });
    } else if (state.deleteStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    }
  }

  /// *** Builder Side *** ///
  /// Get Task Status List For This Project
  Widget getProjectStatusList(
    ProjectStatusTeamMeetingState state,
    int projectId,
  ) {
    if (state.showStatus == CasualStatus.loading) {
      return LoadingStatusCard();
    } else if (state.showStatus == CasualStatus.success) {
      // تحويل الـ StatusModel إلى ProjectStatus
      List<ProjectStatus> statuses =
          state.showStatusList
              .map((status) => mapStatusModelToProjectStatus(status, projectId))
              .toList();

      // تخزينهم في Hive
      cacheStatuses(statuses);
      return StatusKanbanView(
        statusList: state.showStatusList,
        projectId: projectId,
      );
    } else if (state.showStatus == CasualStatus.failure) {
      return ErrorStatusAnimation(errorMessage: state.message);
    } else {
      return SizedBox();
    }
  }

  // list of status for project board
  Widget getProjectBoardList(
    ProjectStatusTeamMeetingState state,
    int projectId,
  ) {
    if (state.projectBoardListStatus == CasualStatus.loading) {
      return LoadingStatusCard();
    } else if (state.projectBoardListStatus == CasualStatus.success) {
      // return Text("Success");
      if (state.projectBoardList.isEmpty) {
        return EmptyStatusAnimation();
      } else {
        return BoardKanbanView(
          statusList: state.projectBoardList,
          projectId: projectId,
        );
      }
    } else if (state.projectBoardListStatus == CasualStatus.failure) {
      return ErrorStatusAnimation(errorMessage: state.message);
    } else {
      return SizedBox();
    }
  }
}
