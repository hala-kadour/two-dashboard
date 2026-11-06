import 'dart:convert';

import 'team_model.dart';

CreateTeamResponseModel createTeamResponseModelFromJson(String str) =>
    CreateTeamResponseModel.fromJson(json.decode(str));

String createTeamResponseModelToJson(CreateTeamResponseModel data) =>
    json.encode(data.toJson());

class CreateTeamResponseModel {
  final int status;
  final String msg;
  final TeamModel data;

  CreateTeamResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory CreateTeamResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateTeamResponseModel(
        status: json["status"],
        msg: json["msg"],
        data: TeamModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}
