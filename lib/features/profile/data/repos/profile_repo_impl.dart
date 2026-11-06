import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/network/network_connection_checker.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/profile_param.dart';
import 'package:two_dashboard/features/profile/data/datasources/profile_locale_datasource.dart';
import 'package:two_dashboard/features/profile/data/datasources/profile_remote_datasourse.dart';
import 'package:two_dashboard/features/profile/domain/entities/client_entity.dart';
import 'package:two_dashboard/features/profile/domain/entities/employee_entity.dart';
import 'package:two_dashboard/features/profile/domain/repos/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  final ProfileRemoteDatasourse profileRemoteDatasourse;
  final ProfileLocaleDatasource profileLocaleDatasourse;
  final NetworkInfoImpl networkInfo;

  ProfileRepoImpl(
    this.profileRemoteDatasourse,
    this.profileLocaleDatasourse,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, Unit>> updateEmployeeProfile(
    UpdateEmployeeProfileParam param,
  ) {
    return wrapHandling(
      tryCall: () async {
        await profileRemoteDatasourse.updateEmployeeProfile(param);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, List<EmployeeEntity>>> showUsersWithFilter(
    ShowUsersParam param,
  ) {
    return wrapHandling(
      tryCall: () async {
        final result = await profileRemoteDatasourse.showUserWithFilter(param);
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, List<ClientEntity>>> showClients() {
    return wrapHandling(
      tryCall: () async {
        final result = await profileRemoteDatasourse.showClients();
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> toggleUserApproved(TokenWithIdParam user) {
    return wrapHandling(
      tryCall: () async {
        await profileRemoteDatasourse.toggleUserApproved(user);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, EmployeeEntity>> getUserProfile(String token) {
    return wrapHandling(
      tryCall: () async {
        if (await networkInfo.isConnected) {
          final remoteProfile = await profileRemoteDatasourse.getUserProfile(
            token,
          );
          profileLocaleDatasourse.cacheUserProfile(remoteProfile.data);
          return Right(remoteProfile.data);
        } else {
          final localProfile = await profileLocaleDatasourse.getUserProfile();
          return Right(localProfile);
        }
      },
    );
  }

  @override
  Future<Either<Failure, Uint8List>> getImage(String imagePath) {
    return wrapHandling(
      tryCall: () async {
        final result = await profileRemoteDatasourse.getImage(imagePath);
        return Right(result);
      },
    );
  }
}
