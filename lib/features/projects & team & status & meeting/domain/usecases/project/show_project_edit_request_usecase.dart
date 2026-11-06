import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/show_project_edit_request_response_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/project_repo.dart';

class ShowProjectEditRequestUsecase
    extends
        UseCase<Future<Either<Failure, List<MessageModel>>>, TokenWithIdParam> {
  final ProjectRepo projectRepo;

  ShowProjectEditRequestUsecase(this.projectRepo);

  @override
  Future<Either<Failure, List<MessageModel>>> call(TokenWithIdParam param) {
    return projectRepo.showProjectEditRequest(param);
  }
}
