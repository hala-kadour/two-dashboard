import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/error/handling_exception_manager.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/profile_param.dart';
import 'package:two_dashboard/features/profile/domain/entities/client_entity.dart';
import 'package:two_dashboard/features/profile/domain/entities/employee_entity.dart';

abstract class ProfileRepo with HandlingExceptionManager {
  Future<Either<Failure, Unit>> updateEmployeeProfile(
    UpdateEmployeeProfileParam param,
  );
  Future<Either<Failure, EmployeeEntity>> getUserProfile(String token);
  Future<Either<Failure, List<EmployeeEntity>>> showUsersWithFilter(
    ShowUsersParam param,
  );
  Future<Either<Failure, List<ClientEntity>>> showClients();
  Future<Either<Failure, Unit>> toggleUserApproved(TokenWithIdParam user);
  Future<Either<Failure, Uint8List>> getImage(String imagePath);
}
