import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/error/handling_exception_manager.dart';
import 'package:two_dashboard/core/param/team_param.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/team_entity.dart';

abstract class TeamRepo with HandlingExceptionManager {
  Future<Either<Failure, TeamEntity>> createTeam(CreateTeamParam param);
  Future<Either<Failure, TeamEntity>> addMembers(AddTeamMembersParam param);
  Future<Either<Failure, List<TeamEntity>>> showTeams();
  Future<Either<Failure, Unit>> addTeam(AddTeamParam param);
}
