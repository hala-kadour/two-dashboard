import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/project_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/project_repo.dart';

class RejectProjectUsecase
    extends UseCase<Future<Either<Failure, Unit>>, RejectProjectParam> {
  final ProjectRepo projectRepo;

  RejectProjectUsecase(this.projectRepo);

  @override
  Future<Either<Failure, Unit>> call(RejectProjectParam param) {
    return projectRepo.rejectProject(param);
  }
}
