import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/status_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/status_repo.dart';

class CreateStatusUsecase
    extends UseCase<Future<Either<Failure, Unit>>, CreateStatusParam> {
  final StatusRepo statusRepo;

  CreateStatusUsecase(this.statusRepo);

  @override
  Future<Either<Failure, Unit>> call(CreateStatusParam param) {
    return statusRepo.createStatus(param);
  }
}
