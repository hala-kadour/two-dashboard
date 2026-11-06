import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/service_param.dart';
import 'package:two_dashboard/features/services/data/datasources/service_remote_datasource.dart';
import 'package:two_dashboard/features/services/domain/entities/service_entity.dart';
import 'package:two_dashboard/features/services/domain/repos/service_repo.dart';

class ServiceRepoImpl extends ServiceRepo {
  final ServiceRemoteDatasource serviceRemoteDatasource;

  ServiceRepoImpl(this.serviceRemoteDatasource);
  @override
  Future<Either<Failure, ServiceEntity>> createService(
    CreateServiceParam param,
  ) {
    return wrapHandling(
      tryCall: () async {
        final result = await serviceRemoteDatasource.createService(param);
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteService(TokenWithIdParam service) {
    return wrapHandling(
      tryCall: () async {
        await serviceRemoteDatasource.deleteService(service);
        return const Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, List<ServiceEntity>>> showService() {
    return wrapHandling(
      tryCall: () async {
        final result = await serviceRemoteDatasource.showServices();
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> updateService(UpdateServiceParam service) {
    return wrapHandling(
      tryCall: () async {
        await serviceRemoteDatasource.updateService(service);
        return const Right(unit);
      },
    );
  }
}
