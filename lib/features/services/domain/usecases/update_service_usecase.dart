import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/service_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/services/domain/repos/service_repo.dart';

class UpdateServiceUsecase
    extends UseCase<Future<Either<Failure, Unit>>, UpdateServiceParam> {
  final ServiceRepo serviceRepo;

  UpdateServiceUsecase(this.serviceRepo);

  @override
  Future<Either<Failure, Unit>> call(UpdateServiceParam param) {
    return serviceRepo.updateService(param);
  }
}
