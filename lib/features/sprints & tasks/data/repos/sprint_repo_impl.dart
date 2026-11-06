import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/sprint_param.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/data/datasource/sprints_remote_datasource.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/data/models/sprint/sprint.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/sprint_entity.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/repos/sprint_repo.dart';

class SprintRepoImpl extends SprintRepo {
  SprintRepoImpl(this.sprintsRemoteDatasource);

  final SprintsRemoteDatasource sprintsRemoteDatasource;
  @override
  Future<Either<Failure, Unit>> createSprint(CreateSprintParam param) {
    return wrapHandling(
      tryCall: () async {
        sprintsRemoteDatasource.createSprint(param);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteSprint(TokenWithIdParam sprint) {
    return wrapHandling(
      tryCall: () async {
        sprintsRemoteDatasource.deleteSprint(sprint);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, List<SprintEntity>>> showProjectSprints(
    TokenWithIdParam project,
  ) {
    return wrapHandling(
      tryCall: () async {
        final result = await sprintsRemoteDatasource.showProjectSprints(
          project,
        );
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, SprintEntity>> showSprintDetails(
    TokenWithIdParam sprint,
  ) {
    return wrapHandling(
      tryCall: () async {
        final result = await sprintsRemoteDatasource.showSprintDetails(sprint);
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> updateSprint(UpdateSprintParam param) {
    return wrapHandling(
      tryCall: () async {
        await sprintsRemoteDatasource.updateSprint(param);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> completeSprint(CompleteSprintParam param) {
    return wrapHandling(
      tryCall: () async {
        await sprintsRemoteDatasource.completeSprint(param);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, List<SprintEntity>>> showProjectStartedSprints(
    TokenWithIdParam project,
  ) {
    return wrapHandling(
      tryCall: () async {
        final result = await sprintsRemoteDatasource.showProjectStartedSprints(
          project,
        );
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, List<Sprint>>> showPenedingSprintsTasks(
    TokenWithIdParam project,
  ) {
    return wrapHandling(
      tryCall: () async {
        final result = await sprintsRemoteDatasource.showPenedingSprintsTasks(
          project,
        );
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, List<SprintEntity>>> showProjectUnCompleteSprints(
    TokenWithIdParam project,
  ) {
    return wrapHandling(
      tryCall: () async {
        final result = await sprintsRemoteDatasource
            .showProjectUnCompleteSprints(project);
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> startSprint(StartSprintParam param) {
    return wrapHandling(
      tryCall: () async {
        await sprintsRemoteDatasource.startSprint(param);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> createBacklogTasksSprint(
    CreateBacklogSprintParam param,
  ) {
    return wrapHandling(
      tryCall: () async {
        await sprintsRemoteDatasource.createBacklogSprint(param);
        return Right(unit);
      },
    );
  }
}
