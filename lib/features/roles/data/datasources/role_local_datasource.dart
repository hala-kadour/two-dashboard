import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:two_dashboard/features/roles/data/models/role_response_model.dart';

import '../../../../core/error/exceptions.dart';

abstract class RoleLocalDatasource {
  Future<List<RoleModel>> getCachedRoles();
  Future<Unit> cacheRoles(List<RoleModel> roleList);
}

// ignore: constant_identifier_names
const String CACHED_ROLES = "CACHED-ROLES";

class RoleLocalDatasourceImpl extends RoleLocalDatasource {
  get sharedPreferences => null;

  @override
  Future<Unit> cacheRoles(List<RoleModel> roleList) async {
    final box = Hive.box<RoleModel>(CACHED_ROLES);
    await box.clear();
    for (var role in roleList) {
      await box.put(role.id, role);
    }
    return Future.value(unit);
  }

  @override
  Future<List<RoleModel>> getCachedRoles() {
    final box = Hive.box<RoleModel>(CACHED_ROLES);
    if (box.isEmpty) {
      throw EmptyCacheException(message: "Empty Cache Exception");
    } else {
      return Future.value(box.values.toList());
    }
  }
}
