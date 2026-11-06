import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/error/handling_exception_manager.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/project_param.dart';
import 'package:two_dashboard/core/param/team_param.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/project_assign_request_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/show_project_edit_request_response_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/project_entity.dart';

abstract class ProjectRepo with HandlingExceptionManager {
  Future<Either<Failure, ProjectEntity>> createProject(
    UpdateProjectParam param,
  );
  Future<Either<Failure, Unit>> updateProject(UpdateProjectParam param);
  Future<Either<Failure, Unit>> deleteProject(TokenWithIdParam project);
  Future<Either<Failure, List<ProjectEntity>>> showPublicProjects();
  Future<Either<Failure, List<ProjectEntity>>> showAllProjects(String token);
  Future<Either<Failure, List<ProjectEntity>>> showUserProjects(String token);
  Future<Either<Failure, List<ProjectEntity>>> showPendingProjects(
    String token,
  );
  Future<Either<Failure, List<MessageModel>>> showProjectEditRequest(
    TokenWithIdParam project,
  );
  Future<Either<Failure, Unit>> rejectProject(RejectProjectParam param);
  Future<Either<Failure, Unit>> approveProject(TokenWithIdParam project);
  Future<Either<Failure, Unit>> specifyProjectTeam(AddTeamParam param);

  /// Will return the project assign request list from the TM to the PM
  Future<Either<Failure, List<ProjectAssignRequestModel>>>
  showProjectAssignRequestList(String token);
  Future<Either<Failure, Unit>> projectManagerAcceptProject(
    TokenWithIdParam project,
  );
  Future<Either<Failure, Unit>> projectManagerRejectProject(
    RejectProjectParam param,
  );

  /// Will return the project accepted assigned list for the PM
  Future<Either<Failure, List<ProjectAssignRequestModel>>>
  showProjectAcceptedAssignedList(String token);

  /// PM senting project edit request for the client
  Future<Either<Failure, Unit>> projectManagerSentEditProjectRequest(param);

  Future<Either<Failure, Unit>> projectManagerUpdateProjectTime(
    UpdateProjectDateParam param,
  );
  Future<Either<Failure, Unit>> projectManagerCompleteProject(
    TokenWithIdParam project,
  );

  Future<Either<Failure, Unit>> adminPermitDevelopingProject(
    TokenWithIdParam project,
  );
}
