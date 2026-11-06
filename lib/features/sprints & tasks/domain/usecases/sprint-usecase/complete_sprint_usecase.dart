import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/sprint_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/repos/sprint_repo.dart';

class CompleteSprintUsecase
    extends UseCase<Future<Either<Failure, Unit>>, CompleteSprintParam> {
  final SprintRepo sprintRepo;

  CompleteSprintUsecase(this.sprintRepo);

  @override
  Future<Either<Failure, Unit>> call(CompleteSprintParam param) {
    return sprintRepo.completeSprint(param);
  }
}
