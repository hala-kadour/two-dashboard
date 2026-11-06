import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/services/domain/repos/service_repo.dart';

class DeleteServiceUsecase
    extends UseCase<Future<Either<Failure, Unit>>, TokenWithIdParam> {
  final ServiceRepo serviceRepo;

  DeleteServiceUsecase(this.serviceRepo);

  @override
  Future<Either<Failure, Unit>> call(TokenWithIdParam param) {
    return serviceRepo.deleteService(param);
  }
}
