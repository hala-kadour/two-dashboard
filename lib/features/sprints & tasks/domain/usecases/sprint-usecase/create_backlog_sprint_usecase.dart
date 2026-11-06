import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/sprint_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/repos/sprint_repo.dart';

class CreateBacklogSprintUsecase
    extends UseCase<Future<Either<Failure, Unit>>, CreateBacklogSprintParam> {
  final SprintRepo sprintRepo;

  CreateBacklogSprintUsecase(this.sprintRepo);

  @override
  Future<Either<Failure, Unit>> call(CreateBacklogSprintParam param) {
    return sprintRepo.createBacklogTasksSprint(param);
  }
}
