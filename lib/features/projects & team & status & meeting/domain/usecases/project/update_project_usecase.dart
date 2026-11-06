import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/param/project_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/project_repo.dart';

import '../../../../../core/error/failures.dart';

class UpdateProjectUsecase
    extends UseCase<Future<Either<Failure, Unit>>, UpdateProjectParam> {
  final ProjectRepo projectRepo;

  UpdateProjectUsecase(this.projectRepo);

  @override
  Future<Either<Failure, Unit>> call(UpdateProjectParam param) {
    return projectRepo.updateProject(param);
  }
}
