import 'dart:convert';

import 'package:two_dashboard/features/profile/data/models/employee_model.dart';

ShowUsersWithFilterResponseModel showUsersWithFilterResponseModelFromJson(
  String str,
) => ShowUsersWithFilterResponseModel.fromJson(json.decode(str));

String showUsersWithFilterResponseModelToJson(
  ShowUsersWithFilterResponseModel data,
) => json.encode(data.toJson());

class ShowUsersWithFilterResponseModel {
  final int status;
  final String msg;
  final List<EmployeeModel> data;

  ShowUsersWithFilterResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory ShowUsersWithFilterResponseModel.fromJson(Map<String, dynamic> json) {
    return ShowUsersWithFilterResponseModel(
      status: json["status"],
      msg: json["msg"],
      data:
          json["data"] == null
              ? []
              : List<EmployeeModel>.from(
                json["data"].map((x) => EmployeeModel.fromJson(x)),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
