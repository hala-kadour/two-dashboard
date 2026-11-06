part of 'project_status_team_meeting_bloc.dart';

class ProjectStatusTeamMeetingEvent {}

////////////////////////////////////////////////////////////////////////////////
/////////////////////////   Project Events  ///////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
class CreateProjectEvent extends ProjectStatusTeamMeetingEvent {
  UpdateProjectParam param;

  CreateProjectEvent({required this.param});
}

class UpdateProjectEvent extends ProjectStatusTeamMeetingEvent {
  final int projectId;
  final String projectType;
  final String projectDescription;
  final String requirements;
  final String? document;
  final String cooperationType;
  final String contactTime;
  final int visibility;
  UpdateProjectEvent({
    required this.projectId,
    required this.projectType,
    required this.projectDescription,
    required this.requirements,
    required this.document,
    required this.cooperationType,
    required this.contactTime,
    required this.visibility,
  });
}

class DeleteProjectsEvent extends ProjectStatusTeamMeetingEvent {
  final int projectId;

  DeleteProjectsEvent({required this.projectId});
}

class ApproveProjectsEvent extends ProjectStatusTeamMeetingEvent {
  final int projectId;

  ApproveProjectsEvent({required this.projectId});
}

class RejectProjectsEvent extends ProjectStatusTeamMeetingEvent {
  final int projectId;
  final String message;

  RejectProjectsEvent({required this.projectId, required this.message});
}

class ShowEditProjectRequestEvent extends ProjectStatusTeamMeetingEvent {
  final int projectId;

  ShowEditProjectRequestEvent({required this.projectId});
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////   Project Manager Stuff  /////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// Accept Project
class ProjectManagerAcceptProjectEvent extends ProjectStatusTeamMeetingEvent {
  final int projectId;

  ProjectManagerAcceptProjectEvent({required this.projectId});
}

// Reject Project
class ProjectManagerRejectProjectEvent extends ProjectStatusTeamMeetingEvent {
  final int projectId;
  final String message;

  ProjectManagerRejectProjectEvent({
    required this.projectId,
    required this.message,
  });
}

// Sent Edit Request
class ProjectManagerSentEditProjectRequestEvent
    extends ProjectStatusTeamMeetingEvent {
  final int projectId;
  final String message;

  ProjectManagerSentEditProjectRequestEvent({
    required this.projectId,
    required this.message,
  });
}

// update project date
class ProjectMangerUpdateProjectDateEvent
    extends ProjectStatusTeamMeetingEvent {
  final String projectId;
  final String startDate;
  final String endDate;

  ProjectMangerUpdateProjectDateEvent({
    required this.projectId,
    required this.startDate,
    required this.endDate,
  });
}

// complete project
class ProjectManagerCompleteProjectEvent extends ProjectStatusTeamMeetingEvent {
  final int projectId;

  ProjectManagerCompleteProjectEvent({required this.projectId});
}

// Show Assign Request List
class ShowProjectAssignRequestListEvent extends ProjectStatusTeamMeetingEvent {}

// Show Accepted Assigned List
class ShowProjectAcceptedAssignedListEvent
    extends ProjectStatusTeamMeetingEvent {}

////////////////////////////////////////////////////////////////////////////////
////////////////////////   Project Lists Events  //////////////////////////////
//////////////////////////////////////////////////////////////////////////////
class ShowAllProjectsEvent extends ProjectStatusTeamMeetingEvent {}

class ShowPublicProjectsEvent extends ProjectStatusTeamMeetingEvent {}

class ShowUserProjectsEvent extends ProjectStatusTeamMeetingEvent {}

class ShowPendedProjectsEvent extends ProjectStatusTeamMeetingEvent {}

// Status Events
class CreateStatusEvent extends ProjectStatusTeamMeetingEvent {
  final int projectId;
  final String statusName;

  CreateStatusEvent({required this.projectId, required this.statusName});
}

class DeleteStatusEvent extends ProjectStatusTeamMeetingEvent {
  final int projectId;
  final int statusId;

  DeleteStatusEvent({required this.projectId, required this.statusId});
}

class UpdateStatusOrderEvent extends ProjectStatusTeamMeetingEvent {
  final int projectId;
  final int statusId;
  final int newOrder;

  UpdateStatusOrderEvent({
    required this.projectId,
    required this.statusId,
    required this.newOrder,
  });
}

class ShowProjectStatusEvent extends ProjectStatusTeamMeetingEvent {
  final int projectId;

  ShowProjectStatusEvent({required this.projectId});
}

class ShowProjectBoardEvent extends ProjectStatusTeamMeetingEvent {
  final int projectId;
  final List<int> sprintsIdList;

  ShowProjectBoardEvent({required this.projectId, required this.sprintsIdList});
}

///////////////////////////////////////////////////////////////////////////////
/////////////////////////////   Team Eevents  ////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
class CreateTeamEvent extends ProjectStatusTeamMeetingEvent {
  final String name;
  final int mgrId;
  final List<int> memebersIdList;

  CreateTeamEvent({
    required this.name,
    required this.mgrId,
    required this.memebersIdList,
  });
}

class AddMembersEvent extends ProjectStatusTeamMeetingEvent {
  final int teamId;
  final List<int> memebersIdList;

  AddMembersEvent({required this.teamId, required this.memebersIdList});
}

class ShowTeamsEvent extends ProjectStatusTeamMeetingEvent {}

class AddProjectTeamEvent extends ProjectStatusTeamMeetingEvent {
  final int projectId;
  final int teamId;

  AddProjectTeamEvent({required this.projectId, required this.teamId});
}

///////////////////////////////////////////////////////////////////////////////
/////////////////////////////   Meeting Eevents  /////////////////////////////
/////////////////////////////////////////////////////////////////////////////

// Craete Meeting
class CreateMeetingEvent extends ProjectStatusTeamMeetingEvent {
  final String projectId;
  final String meetingDate;
  final String meetingType;

  CreateMeetingEvent({
    required this.projectId,
    required this.meetingDate,
    required this.meetingType,
  });
}

// Update Meeting
class UpdateMeetingEvent extends ProjectStatusTeamMeetingEvent {
  final String projectId;
  final String meetingId;
  final String meetingDate;
  final String meetingType;

  UpdateMeetingEvent({
    required this.projectId,
    required this.meetingId,
    required this.meetingDate,
    required this.meetingType,
  });
}

// Delete Meeting
class DeleteMeetingEvent extends ProjectStatusTeamMeetingEvent {
  final String projectId;
  final String meetingId;

  DeleteMeetingEvent({required this.projectId, required this.meetingId});
}

// Show Project Meetings
class ShowProjectMeetingsEvent extends ProjectStatusTeamMeetingEvent {
  final int projectId;

  ShowProjectMeetingsEvent({required this.projectId});
}
