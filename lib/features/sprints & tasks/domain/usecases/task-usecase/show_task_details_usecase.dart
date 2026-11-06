import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/task_entity.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/repos/task_repo.dart';

class ShowTaskDetailsUsecase
    extends UseCase<Future<Either<Failure, TaskEntity>>, TokenWithIdParam> {
  ShowTaskDetailsUsecase(this.taskRepo);
  final TaskRepo taskRepo;

  @override
  Future<Either<Failure, TaskEntity>> call(TokenWithIdParam param) {
    return taskRepo.showTaskDetails(param);
  }
}
