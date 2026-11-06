import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/usecases/no_param_use_case.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/project_entity.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/project_repo.dart';

class ShowPublicProjectsUsecase
    extends NoParamUseCase<Future<Either<Failure, List<ProjectEntity>>>> {
  final ProjectRepo projectRepo;

  ShowPublicProjectsUsecase(this.projectRepo);
  @override
  Future<Either<Failure, List<ProjectEntity>>> call() {
    return projectRepo.showPublicProjects();
  }
}
