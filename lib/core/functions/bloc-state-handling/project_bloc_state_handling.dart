import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/animation/error_status_animation.dart';
import 'package:two_dashboard/core/widgets/animation/loading_status_animation.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/project/assigned/assigned_project_table.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/project/assigned/loading_assigned_project_table.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/project/pended/loading_pended_project_table.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/project/casual/loading_project_table.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/project/pended/pended_project_table.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/project/casual/project_table.dart';
import 'package:two_dashboard/core/widgets/dialog/status/error_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/loading_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/not_authorized_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/success_dialog.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/team.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/widgets/project-details/message_card.dart';

class ProjectBlocStateHandling {
  // Approve Project
  void approveProject(
    ProjectStatusTeamMeetingState state,
    BuildContext context,
  ) {
    if (state.approveProjectStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.approveProjectStatus == CasualStatus.success) {
      context.pop();
      context.read<ProjectStatusTeamMeetingBloc>().add(
        ShowPendedProjectsEvent(),
      );
      showSuccessDialog(context, () {
        context.pop();
      });
    } else if (state.approveProjectStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.approveProjectStatus == CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  // Reject Project
  void rejectProject(
    ProjectStatusTeamMeetingState state,
    BuildContext context,
  ) {
    if (state.rejectProjectStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.rejectProjectStatus == CasualStatus.success) {
      context.pop();
      context.read<ProjectStatusTeamMeetingBloc>().add(
        ShowPendedProjectsEvent(),
      );
      showSuccessDialog(context, () {
        context.pop();
      });
    } else if (state.rejectProjectStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.rejectProjectStatus == CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  // Update Project
  void updateProject(
    ProjectStatusTeamMeetingState state,
    BuildContext context,
  ) {
    if (state.updateProjectStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.updateProjectStatus == CasualStatus.success) {
      context.pop();
      showSuccessDialog(context, () {
        context.pop();
      });
    } else if (state.updateProjectStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.updateProjectStatus == CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  // Create Project
  void createProject(
    ProjectStatusTeamMeetingState state,
    BuildContext context,
  ) {
    if (state.createProjectStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.createProjectStatus == CasualStatus.success) {
      context.pop();
      context.read<ProjectStatusTeamMeetingBloc>().add(ShowAllProjectsEvent());
      showSuccessDialog(context, () {
        context.pushReplacementNamed(AppRouteConfig.allProjects);
        context.pop();
      });
    } else if (state.createProjectStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.createProjectStatus == CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  // Get All Projects Table
  Widget getAllProjectsTable(ProjectStatusTeamMeetingState state) {
    if (state.allProjectsListStatus == CasualStatus.loading) {
      return const LoadingProjectTable();
    } else if (state.allProjectsListStatus == CasualStatus.success) {
      for (int i = 0; i < state.allProjectsList.length; i++) {
        var project = state.allProjectsList[i];
        if (project.team != null) {
          print("**********************************************");
          print("Project Team ${project.team!.members.asMap()}");
          print("**********************************************");
          cacheTeamForProject(project.id, project.team!);
        }
      }
      return ProjectTable(projectList: state.allProjectsList);
    } else if (state.allProjectsListStatus == CasualStatus.failure) {
      return Center(child: ErrorStatusAnimation(errorMessage: state.message));
    } else {
      return const SizedBox();
    }
  }

  // Get My Projects Table
  Widget getUserProjectsTable(ProjectStatusTeamMeetingState state) {
    if (state.userProjectsListStatus == CasualStatus.loading) {
      return const LoadingProjectTable();
    } else if (state.userProjectsListStatus == CasualStatus.success) {
      for (int i = 0; i < state.userProjectsList.length; i++) {
        var project = state.userProjectsList[i];
        if (project.team != null) {
          cacheTeamForProject(project.id, project.team!);
        }
      }
      return ProjectTable(projectList: state.userProjectsList);
    } else if (state.userProjectsListStatus == CasualStatus.failure) {
      return Center(child: ErrorStatusAnimation(errorMessage: state.message));
    } else {
      return const SizedBox();
    }
  }

  // Get Pended Projects Table
  Widget getPendedProjectsTable(ProjectStatusTeamMeetingState state) {
    if (state.pendedProjectListStatus == CasualStatus.loading) {
      return const LoadingPendedProjectTable();
    } else if (state.pendedProjectListStatus == CasualStatus.success) {
      return PendedProjectTable(projectList: state.pendedProjectList);
    } else if (state.pendedProjectListStatus == CasualStatus.failure) {
      return Center(child: ErrorStatusAnimation(errorMessage: state.message));
    } else {
      return const SizedBox();
    }
  }

  ////////////////////// PROJECT MANAGER SIDE /////////////////////////////
  // Accept Project
  void projectManagerAcceptProject(
    ProjectStatusTeamMeetingState state,
    BuildContext context,
  ) {
    if (state.projectManagerAcceptProjectStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.projectManagerAcceptProjectStatus ==
        CasualStatus.success) {
      context.pop();
      context.read<ProjectStatusTeamMeetingBloc>().add(
        ShowProjectAssignRequestListEvent(),
      );
      showSuccessDialog(context, () {
        context.pop();
      });
    } else if (state.projectManagerAcceptProjectStatus ==
        CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.projectManagerAcceptProjectStatus ==
        CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  // Reject Project
  void projectManagerRejectProject(
    ProjectStatusTeamMeetingState state,
    BuildContext context,
  ) {
    if (state.projectManagerRejectProjectStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.projectManagerRejectProjectStatus ==
        CasualStatus.success) {
      context.pop();
      showSuccessDialog(context, () {
        context.read<ProjectStatusTeamMeetingBloc>().add(
          ShowProjectAssignRequestListEvent(),
        );
        context.pop();
      });
    } else if (state.projectManagerRejectProjectStatus ==
        CasualStatus.failure) {
      print("**************************");
      print(state.message);
      print("**************************");
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.projectManagerRejectProjectStatus ==
        CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  // Sent Edit Project Request
  void sentEditProjectMessage(
    ProjectStatusTeamMeetingState state,
    BuildContext context,
  ) {
    if (state.projectManagerSentEditProjectRequest == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.projectManagerSentEditProjectRequest ==
        CasualStatus.success) {
      context.pop();
      showSuccessDialog(context, () {
        context.pop();
      });
    } else if (state.projectManagerSentEditProjectRequest ==
        CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.projectManagerSentEditProjectRequest ==
        CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  void completeProject(
    ProjectStatusTeamMeetingState state,
    BuildContext context,
  ) {
    if (state.projectManagerCompleteProjectStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.projectManagerCompleteProjectStatus ==
        CasualStatus.success) {
      context.pop();
      context.read<ProjectStatusTeamMeetingBloc>().add(ShowUserProjectsEvent());
      showSuccessDialog(context, () {
        context.goNamed(AppRouteConfig.myProjects);
        context.pop();
      });
    } else if (state.projectManagerCompleteProjectStatus ==
        CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.projectManagerCompleteProjectStatus ==
        CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  void updateDeadline(
    ProjectStatusTeamMeetingState state,
    BuildContext context,
  ) {
    if (state.projectManagerUpdateProjectDateStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.projectManagerUpdateProjectDateStatus ==
        CasualStatus.success) {
      context.pop();
      context.read<ProjectStatusTeamMeetingBloc>().add(ShowUserProjectsEvent());
      showSuccessDialog(context, () {
        context.goNamed(AppRouteConfig.myProjects);
        context.pop();
      });
    } else if (state.projectManagerUpdateProjectDateStatus ==
        CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.projectManagerUpdateProjectDateStatus ==
        CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  // Get Assign Project Requests
  Widget getAssignProjectsRequestTable(ProjectStatusTeamMeetingState state) {
    if (state.projectAssignRequestListStatus == CasualStatus.loading) {
      return const LoadingAssignedProjectTable();
    } else if (state.projectAssignRequestListStatus == CasualStatus.success) {
      return AssignedProjectTable(projectList: state.projectAssignRequestList);
    } else if (state.projectAssignRequestListStatus == CasualStatus.failure) {
      return Center(child: ErrorStatusAnimation(errorMessage: state.message));
    } else {
      return const SizedBox();
    }
  }

  Widget showEditProjectRequestList(ProjectStatusTeamMeetingState state) {
    if (state.editProjectRequestsListStatus == CasualStatus.loading) {
      return Center(child: LoadingStatusAnimation());
    } else if (state.editProjectRequestsListStatus == CasualStatus.success) {
      return SizedBox(
        height: 600,
        child: ListView.builder(
          itemCount: state.editProjectRequestsList.length,
          itemBuilder:
              (context, index) => MessageCard(
                messageModel: state.editProjectRequestsList[index],
              ),
        ),
      );
    } else if (state.editProjectRequestsListStatus == CasualStatus.failure) {
      return ErrorStatusAnimation(errorMessage: state.message);
    } else {
      return SizedBox();
    }
  }
}
