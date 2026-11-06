import 'dart:convert';

import 'client_model.dart';

ShowClientsResponseModel showClientsResponseModelFromJson(String str) =>
    ShowClientsResponseModel.fromJson(json.decode(str));

String showClientsResponseModelToJson(ShowClientsResponseModel data) =>
    json.encode(data.toJson());

class ShowClientsResponseModel {
  final int status;
  final String msg;
  final List<ClientModel> data;

  ShowClientsResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory ShowClientsResponseModel.fromJson(Map<String, dynamic> json) =>
      ShowClientsResponseModel(
        status: json["status"],
        msg: json["msg"],
        data:
            json["data"] == null
                ? []
                : List<ClientModel>.from(
                  json["data"].map((x) => ClientModel.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
