import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/project_assign_request_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/project_repo.dart';

class ShowProjectAssignRequestListUsecase
    extends
        UseCase<
          Future<Either<Failure, List<ProjectAssignRequestModel>>>,
          String
        > {
  final ProjectRepo projectRepo;

  ShowProjectAssignRequestListUsecase(this.projectRepo);

  @override
  Future<Either<Failure, List<ProjectAssignRequestModel>>> call(String param) {
    return projectRepo.showProjectAssignRequestList(param);
  }
}
