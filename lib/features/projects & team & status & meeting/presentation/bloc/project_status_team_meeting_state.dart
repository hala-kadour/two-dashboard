// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'project_status_team_meeting_bloc.dart';

class ProjectStatusTeamMeetingState {
  final int? statusNum;
  final String message;

  // Project States
  final CasualStatus createProjectStatus;
  final CasualStatus updateProjectStatus;
  final CasualStatus deleteProjectStatus;
  final CasualStatus approveProjectStatus;
  final CasualStatus rejectProjectStatus;
  final CasualStatus editProjectRequestsListStatus;
  final List<MessageModel> editProjectRequestsList;

  // Project Manager Stuff
  final CasualStatus projectManagerAcceptProjectStatus;
  final CasualStatus projectManagerRejectProjectStatus;
  final CasualStatus projectManagerSentEditProjectRequest;
  final List<ProjectAssignRequestModel> projectAssignRequestList;
  final CasualStatus projectAssignRequestListStatus;
  final List<ProjectAssignRequestModel> projectAcceptedAssignedList;
  final CasualStatus projectAcceptedAssignedListStatus;
  final CasualStatus projectManagerUpdateProjectDateStatus;
  final CasualStatus projectManagerCompleteProjectStatus;

  // Public & Private Project List
  final List<ProjectEntity> publicProjectsList;
  final CasualStatus publicProjectsListStatus;
  final List<ProjectEntity> allProjectsList;
  final CasualStatus allProjectsListStatus;
  // Pended Project Lists
  final List<ProjectEntity> pendedProjectList;
  final CasualStatus pendedProjectListStatus;
  // My Project List
  final List<ProjectEntity> userProjectsList;
  final CasualStatus userProjectsListStatus;

  // Status States
  final CasualStatus createStatus;
  final CasualStatus deleteStatus;
  final CasualStatus updateOrderStatus;
  final CasualStatus showStatus;
  final List<StatusModel> showStatusList;
  final CasualStatus projectBoardListStatus;
  final List<StatusBoardModel> projectBoardList;

  // Team States
  final CasualStatus createTeamStatus;
  final CasualStatus addMemersStatus;
  final CasualStatus showTeamsStatus;
  final List<TeamEntity> showTeams;
  final CasualStatus addTeamStatus;

  // Meeting States
  final CasualStatus createMeetingStatus;
  final CasualStatus updateMeetingStatus;
  final CasualStatus deleteMeetingStatus;
  final CasualStatus projectMeetingListStatus;
  final List<MeetingModel> projectMeetingList;

  ProjectStatusTeamMeetingState({
    this.statusNum,
    this.message = "",
    this.createProjectStatus = CasualStatus.initial,
    this.updateProjectStatus = CasualStatus.initial,
    this.deleteProjectStatus = CasualStatus.initial,
    this.approveProjectStatus = CasualStatus.initial,
    this.rejectProjectStatus = CasualStatus.initial,
    this.editProjectRequestsListStatus = CasualStatus.initial,
    this.editProjectRequestsList = const [],
    this.projectManagerAcceptProjectStatus = CasualStatus.initial,
    this.projectManagerRejectProjectStatus = CasualStatus.initial,
    this.projectManagerSentEditProjectRequest = CasualStatus.initial,
    this.projectAssignRequestList = const [],
    this.projectAssignRequestListStatus = CasualStatus.initial,
    this.projectAcceptedAssignedList = const [],
    this.projectAcceptedAssignedListStatus = CasualStatus.initial,
    this.projectManagerUpdateProjectDateStatus = CasualStatus.initial,
    this.projectManagerCompleteProjectStatus = CasualStatus.initial,
    this.publicProjectsList = const [],
    this.publicProjectsListStatus = CasualStatus.initial,
    this.allProjectsList = const [],
    this.allProjectsListStatus = CasualStatus.initial,
    this.pendedProjectList = const [],
    this.pendedProjectListStatus = CasualStatus.initial,
    this.userProjectsList = const [],
    this.userProjectsListStatus = CasualStatus.initial,
    this.createStatus = CasualStatus.initial,
    this.deleteStatus = CasualStatus.initial,
    this.updateOrderStatus = CasualStatus.initial,
    this.showStatusList = const [],
    this.showStatus = CasualStatus.initial,
    this.projectBoardList = const [],
    this.projectBoardListStatus = CasualStatus.initial,
    this.createTeamStatus = CasualStatus.initial,
    this.addMemersStatus = CasualStatus.initial,
    this.showTeamsStatus = CasualStatus.initial,
    this.showTeams = const [],
    this.addTeamStatus = CasualStatus.initial,
    this.createMeetingStatus = CasualStatus.initial,
    this.updateMeetingStatus = CasualStatus.initial,
    this.deleteMeetingStatus = CasualStatus.initial,
    this.projectMeetingListStatus = CasualStatus.initial,
    this.projectMeetingList = const [],
  });

  ProjectStatusTeamMeetingState copyWith({
    int? statusNum,
    String? message,
    CasualStatus? createProjectStatus,
    CasualStatus? updateProjectStatus,
    CasualStatus? deleteProjectStatus,
    CasualStatus? approveProjectStatus,
    CasualStatus? rejectProjectStatus,
    CasualStatus? editProjectRequestsListStatus,
    List<MessageModel>? editProjectRequestsList,
    CasualStatus? projectManagerAcceptProjectStatus,
    CasualStatus? projectManagerRejectProjectStatus,
    CasualStatus? projectManagerSentEditProjectRequest,
    List<ProjectAssignRequestModel>? projectAssignRequestList,
    CasualStatus? projectAssignRequestListStatus,
    List<ProjectAssignRequestModel>? projectAcceptedAssignedList,
    CasualStatus? projectAcceptedAssignedListStatus,
    CasualStatus? projectManagerUpdateProjectDateStatus,
    CasualStatus? projectManagerCompleteProjectStatus,
    List<ProjectEntity>? publicProjectsList,
    CasualStatus? publicProjectsListStatus,
    List<ProjectEntity>? allProjectsList,
    CasualStatus? allProjectsListStatus,
    List<ProjectEntity>? pendedProjectList,
    CasualStatus? pendedProjectListStatus,
    List<ProjectEntity>? userProjectsList,
    CasualStatus? userProjectsListStatus,
    CasualStatus? createStatus,
    CasualStatus? deleteStatus,
    CasualStatus? updateOrderStatus,
    CasualStatus? showStatus,
    List<StatusModel>? showStatusList,
    CasualStatus? projectBoardListStatus,
    List<StatusBoardModel>? projectBoardList,
    CasualStatus? createTeamStatus,
    CasualStatus? addMemersStatus,
    CasualStatus? showTeamsStatus,
    List<TeamEntity>? showTeams,
    CasualStatus? addTeamStatus,
    CasualStatus? createMeetingStatus,
    CasualStatus? updateMeetingStatus,
    CasualStatus? deleteMeetingStatus,
    CasualStatus? projectMeetingListStatus,
    List<MeetingModel>? projectMeetingList,
  }) {
    return ProjectStatusTeamMeetingState(
      statusNum: statusNum ?? this.statusNum,
      message: message ?? this.message,
      createProjectStatus: createProjectStatus ?? this.createProjectStatus,
      updateProjectStatus: updateProjectStatus ?? this.updateProjectStatus,
      deleteProjectStatus: deleteProjectStatus ?? this.deleteProjectStatus,
      approveProjectStatus: approveProjectStatus ?? this.approveProjectStatus,
      rejectProjectStatus: rejectProjectStatus ?? this.rejectProjectStatus,
      editProjectRequestsListStatus:
          editProjectRequestsListStatus ?? this.editProjectRequestsListStatus,
      editProjectRequestsList:
          editProjectRequestsList ?? this.editProjectRequestsList,
      projectManagerAcceptProjectStatus:
          projectManagerAcceptProjectStatus ??
          this.projectManagerAcceptProjectStatus,
      projectManagerRejectProjectStatus:
          projectManagerRejectProjectStatus ??
          this.projectManagerRejectProjectStatus,
      projectManagerSentEditProjectRequest:
          projectManagerSentEditProjectRequest ??
          this.projectManagerSentEditProjectRequest,
      projectAssignRequestList:
          projectAssignRequestList ?? this.projectAssignRequestList,
      projectAssignRequestListStatus:
          projectAssignRequestListStatus ?? this.projectAssignRequestListStatus,
      projectAcceptedAssignedList:
          projectAcceptedAssignedList ?? this.projectAcceptedAssignedList,
      projectAcceptedAssignedListStatus:
          projectAcceptedAssignedListStatus ??
          this.projectAcceptedAssignedListStatus,
      projectManagerUpdateProjectDateStatus:
          projectManagerUpdateProjectDateStatus ??
          this.projectManagerUpdateProjectDateStatus,
      projectManagerCompleteProjectStatus:
          projectManagerCompleteProjectStatus ??
          this.projectManagerCompleteProjectStatus,
      publicProjectsList: publicProjectsList ?? this.publicProjectsList,
      publicProjectsListStatus:
          publicProjectsListStatus ?? this.publicProjectsListStatus,
      allProjectsList: allProjectsList ?? this.allProjectsList,
      allProjectsListStatus:
          allProjectsListStatus ?? this.allProjectsListStatus,
      pendedProjectList: pendedProjectList ?? this.pendedProjectList,
      pendedProjectListStatus:
          pendedProjectListStatus ?? this.pendedProjectListStatus,
      userProjectsList: userProjectsList ?? this.userProjectsList,
      userProjectsListStatus:
          userProjectsListStatus ?? this.userProjectsListStatus,
      createStatus: createStatus ?? this.createStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      updateOrderStatus: updateOrderStatus ?? this.updateOrderStatus,
      showStatus: showStatus ?? this.showStatus,
      showStatusList: showStatusList ?? this.showStatusList,
      projectBoardListStatus:
          projectBoardListStatus ?? this.projectBoardListStatus,
      projectBoardList: projectBoardList ?? this.projectBoardList,
      createTeamStatus: createTeamStatus ?? this.createTeamStatus,
      addMemersStatus: addMemersStatus ?? this.addMemersStatus,
      showTeamsStatus: showTeamsStatus ?? this.showTeamsStatus,
      showTeams: showTeams ?? this.showTeams,
      addTeamStatus: addTeamStatus ?? this.addTeamStatus,
      createMeetingStatus: createMeetingStatus ?? this.createMeetingStatus,
      updateMeetingStatus: updateMeetingStatus ?? this.updateMeetingStatus,
      deleteMeetingStatus: deleteMeetingStatus ?? this.deleteMeetingStatus,
      projectMeetingListStatus:
          projectMeetingListStatus ?? this.projectMeetingListStatus,
      projectMeetingList: projectMeetingList ?? this.projectMeetingList,
    );
  }
}
