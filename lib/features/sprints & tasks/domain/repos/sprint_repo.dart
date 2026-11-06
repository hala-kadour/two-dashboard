import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/error/handling_exception_manager.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/sprint_param.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/data/models/sprint/sprint.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/sprint_entity.dart';

abstract class SprintRepo with HandlingExceptionManager {
  Future<Either<Failure, Unit>> createSprint(CreateSprintParam param);
  Future<Either<Failure, Unit>> updateSprint(UpdateSprintParam param);
  Future<Either<Failure, Unit>> deleteSprint(TokenWithIdParam sprint);
  Future<Either<Failure, Unit>> startSprint(StartSprintParam param);
  Future<Either<Failure, Unit>> completeSprint(CompleteSprintParam param);
  Future<Either<Failure, List<SprintEntity>>> showProjectUnCompleteSprints(
    TokenWithIdParam project,
  );
  Future<Either<Failure, List<SprintEntity>>> showProjectStartedSprints(
    TokenWithIdParam project,
  );
  Future<Either<Failure, List<Sprint>>> showPenedingSprintsTasks(
    TokenWithIdParam project,
  );
  Future<Either<Failure, List<SprintEntity>>> showProjectSprints(
    TokenWithIdParam project,
  );
  Future<Either<Failure, SprintEntity>> showSprintDetails(
    TokenWithIdParam sprint,
  );
  Future<Either<Failure, Unit>> createBacklogTasksSprint(
    CreateBacklogSprintParam param,
  );
}
