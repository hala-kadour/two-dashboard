import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/project_entity.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/project_repo.dart';

class ShowUserProjectsUsecase
    extends UseCase<Future<Either<Failure, List<ProjectEntity>>>, String> {
  final ProjectRepo projectRepo;

  ShowUserProjectsUsecase(this.projectRepo);
  @override
  Future<Either<Failure, List<ProjectEntity>>> call(String param) {
    return projectRepo.showUserProjects(param);
  }
}
