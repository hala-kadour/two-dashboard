import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/task_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/task_entity.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/repos/task_repo.dart';

class ShowMyProjectTasksUsecase
    extends
        UseCase<
          Future<Either<Failure, List<TaskEntity>>>,
          ShowMyProjectTasksParam
        > {
  ShowMyProjectTasksUsecase(this.taskRepo);
  final TaskRepo taskRepo;

  @override
  Future<Either<Failure, List<TaskEntity>>> call(
    ShowMyProjectTasksParam param,
  ) {
    return taskRepo.showMyProjectTasks(param);
  }
}
