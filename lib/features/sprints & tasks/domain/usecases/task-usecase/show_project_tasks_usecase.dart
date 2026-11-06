import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/task_entity.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/repos/task_repo.dart';

class ShowProjectTasksUsecase
    extends
        UseCase<Future<Either<Failure, List<TaskEntity>>>, TokenWithIdParam> {
  final TaskRepo taskRepo;

  ShowProjectTasksUsecase(this.taskRepo);

  @override
  Future<Either<Failure, List<TaskEntity>>> call(TokenWithIdParam param) {
    return taskRepo.showProjectTasks(param);
  }
}
