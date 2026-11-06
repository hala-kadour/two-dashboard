import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/network/network_connection_checker.dart';
import 'package:two_dashboard/features/roles/data/datasources/role_local_datasource.dart';
import 'package:two_dashboard/features/roles/data/datasources/role_remote_datasource.dart';
import 'package:two_dashboard/features/roles/data/models/role_response_model.dart';
import 'package:two_dashboard/features/roles/domain/repos/role_repo.dart';

class RoleRepoImpl extends RoleRepo {
  final RoleLocalDatasource roleLocalDatasource;
  final RoleRemoteDatasource roleRemoteDatasource;
  final NetworkInfo networkInfo;

  RoleRepoImpl(
    this.roleLocalDatasource,
    this.roleRemoteDatasource,
    this.networkInfo,
  );
  @override
  Future<Either<Failure, List<RoleModel>>> showRoleClient() {
    return wrapHandling(
      tryCall: () async {
        final remoteRoles = await roleRemoteDatasource.showRoleClient();
        return Right(remoteRoles.data);
      },
    );
  }

  @override
  Future<Either<Failure, List<RoleModel>>> showRolesWithoutClient() {
    return wrapHandling(
      tryCall: () async {
        final remoteRoles = await roleRemoteDatasource.showRolesWithoutClient();
        return Right(remoteRoles.data);
      },
    );
  }

  @override
  Future<Either<Failure, List<RoleModel>>> showAllRoles() {
    return wrapHandling(
      tryCall: () async {
        if (await networkInfo.isConnected) {
          final remoteRoles = await roleRemoteDatasource.showAllRoles();
          roleLocalDatasource.cacheRoles(remoteRoles.data);
          return Right(remoteRoles.data);
        } else {
          final localRoles = await roleLocalDatasource.getCachedRoles();
          return Right(localRoles);
        }
      },
    );
  }
}
