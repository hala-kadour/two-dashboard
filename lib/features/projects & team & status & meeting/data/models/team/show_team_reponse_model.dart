import 'dart:convert';

import 'team_model.dart';

ShowTeamResponseModel showTeamResponseModelFromJson(String str) =>
    ShowTeamResponseModel.fromJson(json.decode(str));

String showTeamResponseModelToJson(ShowTeamResponseModel data) =>
    json.encode(data.toJson());

class ShowTeamResponseModel {
  final int status;
  final String msg;
  final List<TeamModel> data;

  ShowTeamResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory ShowTeamResponseModel.fromJson(Map<String, dynamic> json) =>
      ShowTeamResponseModel(
        status: json["status"],
        msg: json["msg"],
        data: List<TeamModel>.from(
          json["data"].map((x) => TeamModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
