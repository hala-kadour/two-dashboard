import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/error/handling_exception_manager.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/service_param.dart';
import 'package:two_dashboard/features/services/domain/entities/service_entity.dart';

abstract class ServiceRepo with HandlingExceptionManager {
  Future<Either<Failure, ServiceEntity>> createService(
    CreateServiceParam param,
  );
  Future<Either<Failure, Unit>> deleteService(TokenWithIdParam service);
  Future<Either<Failure, List<ServiceEntity>>> showService();
  Future<Either<Failure, Unit>> updateService(UpdateServiceParam param);
}
