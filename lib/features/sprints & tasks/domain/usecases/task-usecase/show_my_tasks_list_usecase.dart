import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/task_entity.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/repos/task_repo.dart';

class ShowMyTasksListUsecase
    extends UseCase<Future<Either<Failure, List<TaskEntity>>>, String> {
  final TaskRepo taskRepo;

  ShowMyTasksListUsecase(this.taskRepo);

  @override
  Future<Either<Failure, List<TaskEntity>>> call(String param) {
    return taskRepo.showMyTasksList(param);
  }
}
