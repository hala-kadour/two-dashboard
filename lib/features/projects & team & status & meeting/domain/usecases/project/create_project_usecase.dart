import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/param/project_param.dart';

import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/project_entity.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/project_repo.dart';

import '../../../../../core/error/failures.dart';

class CreateProjectUsecase
    extends
        UseCase<Future<Either<Failure, ProjectEntity>>, UpdateProjectParam> {
  final ProjectRepo projectRepo;

  CreateProjectUsecase(this.projectRepo);
  @override
  Future<Either<Failure, ProjectEntity>> call(UpdateProjectParam param) {
    return projectRepo.createProject(param);
  }
}
