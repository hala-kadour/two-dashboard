import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/status/status_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/status_repo.dart';

class ShowStatusUsecase
    extends
        UseCase<Future<Either<Failure, List<StatusModel>>>, TokenWithIdParam> {
  final StatusRepo statusRepo;

  ShowStatusUsecase(this.statusRepo);

  @override
  Future<Either<Failure, List<StatusModel>>> call(TokenWithIdParam param) {
    return statusRepo.showStatus(param);
  }
}
