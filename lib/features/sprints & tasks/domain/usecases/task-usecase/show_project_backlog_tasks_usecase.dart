import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/data/models/task/task_model.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/repos/task_repo.dart';

class ShowProjectBacklogTasksUsecase
    extends
        UseCase<Future<Either<Failure, List<TaskModel>>>, TokenWithIdParam> {
  final TaskRepo taskRepo;

  ShowProjectBacklogTasksUsecase(this.taskRepo);

  @override
  Future<Either<Failure, List<TaskModel>>> call(TokenWithIdParam param) {
    return taskRepo.showProjectBackLogTasks(param);
  }
}
