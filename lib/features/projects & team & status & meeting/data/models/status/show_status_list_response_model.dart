import 'dart:convert';

import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/status/status_model.dart';

ShowStatusListResponseModel showStatusListResponseModelFromJson(String str) =>
    ShowStatusListResponseModel.fromJson(json.decode(str));

String showStatusListResponseModelToJson(ShowStatusListResponseModel data) =>
    json.encode(data.toJson());

class ShowStatusListResponseModel {
  final int status;
  final String msg;
  final List<StatusModel> data;

  ShowStatusListResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory ShowStatusListResponseModel.fromJson(Map<String, dynamic> json) =>
      ShowStatusListResponseModel(
        status: json["status"],
        msg: json["msg"],
        data: List<StatusModel>.from(
          json["data"].map((x) => StatusModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
