import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/team_param.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/datasource/team__remote_data_source.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/team_entity.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/team_repo.dart';

class TeamRepoImpl extends TeamRepo {
  final TeamRemoteDataSource teamRemoteDataSource;

  TeamRepoImpl(this.teamRemoteDataSource);
  @override
  Future<Either<Failure, TeamEntity>> addMembers(AddTeamMembersParam param) {
    return wrapHandling(
      tryCall: () async {
        final result = await teamRemoteDataSource.addMembers(param);
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, TeamEntity>> createTeam(CreateTeamParam param) {
    return wrapHandling(
      tryCall: () async {
        final result = await teamRemoteDataSource.createTeam(param);
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, List<TeamEntity>>> showTeams() {
    return wrapHandling(
      tryCall: () async {
        final result = await teamRemoteDataSource.showTeams();
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> addTeam(AddTeamParam param) {
    return wrapHandling(
      tryCall: () async {
        await teamRemoteDataSource.addTeam(param);
        return Right(unit);
      },
    );
  }
}
