// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:two_dashboard/core/error/exceptions.dart';

import 'package:two_dashboard/features/profile/data/models/employee_model.dart';

abstract class ProfileLocaleDatasource {
  Future<EmployeeModel> getUserProfile();
  Future<Unit> cacheUserProfile(EmployeeModel employeeModel);
}

const String USER_PROFILE = "USER-PROFILE";

class ProfileLocaleDatasourceImpl extends ProfileLocaleDatasource {
  SharedPreferences sharedPreferences;
  ProfileLocaleDatasourceImpl(this.sharedPreferences);
  @override
  Future<Unit> cacheUserProfile(EmployeeModel employeeModel) {
    Map<String, dynamic> userModelToJson = employeeModel.toJson();
    sharedPreferences.setString(USER_PROFILE, json.encode(userModelToJson));
    return Future.value(unit);
  }

  @override
  Future<EmployeeModel> getUserProfile() async {
    final jsonString = sharedPreferences.getString(USER_PROFILE);
    if (jsonString != null) {
      Map<String, dynamic> decodeJsonData = json.decode(jsonString);
      EmployeeModel employeeModel = EmployeeModel.fromJson(decodeJsonData);
      return employeeModel;
    } else {
      throw EmptyCacheException(message: "Empty Cache Exception");
    }
  }
}
