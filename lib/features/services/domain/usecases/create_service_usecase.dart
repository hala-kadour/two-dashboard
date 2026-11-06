import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/service_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/services/domain/entities/service_entity.dart';
import 'package:two_dashboard/features/services/domain/repos/service_repo.dart';

class CreateServiceUsecase
    extends
        UseCase<Future<Either<Failure, ServiceEntity>>, CreateServiceParam> {
  CreateServiceUsecase(this.serviceRepo);

  final ServiceRepo serviceRepo;
  @override
  Future<Either<Failure, ServiceEntity>> call(CreateServiceParam param) {
    return serviceRepo.createService(param);
  }
}
