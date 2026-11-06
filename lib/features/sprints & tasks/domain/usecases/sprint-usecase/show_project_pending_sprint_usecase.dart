import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/data/models/sprint/sprint.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/repos/sprint_repo.dart';

class ShowProjectPendedSprintsUsecase
    extends UseCase<Future<Either<Failure, List<Sprint>>>, TokenWithIdParam> {
  final SprintRepo sprintRepo;

  ShowProjectPendedSprintsUsecase(this.sprintRepo);

  @override
  Future<Either<Failure, List<Sprint>>> call(TokenWithIdParam param) {
    return sprintRepo.showPenedingSprintsTasks(param);
  }
}
