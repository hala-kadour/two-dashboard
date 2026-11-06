import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/status_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/status_repo.dart';

class DeleteStatusUsecase
    extends UseCase<Future<Either<Failure, Unit>>, DeleteStatusParam> {
  final StatusRepo statusRepo;

  DeleteStatusUsecase(this.statusRepo);

  @override
  Future<Either<Failure, Unit>> call(DeleteStatusParam param) {
    return statusRepo.deleteStatus(param);
  }
}
