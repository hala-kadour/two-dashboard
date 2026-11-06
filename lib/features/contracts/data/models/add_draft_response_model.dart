import 'dart:convert';

import 'package:two_dashboard/features/contracts/data/models/contract_model.dart';

AddDraftResponseModel addDraftResponseModelFromJson(String str) =>
    AddDraftResponseModel.fromJson(json.decode(str));

String addDraftResponseModelToJson(AddDraftResponseModel data) =>
    json.encode(data.toJson());

class AddDraftResponseModel {
  final int status;
  final String msg;
  final ContractModel data;

  AddDraftResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory AddDraftResponseModel.fromJson(Map<String, dynamic> json) =>
      AddDraftResponseModel(
        status: json["status"],
        msg: json["msg"],
        data: ContractModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}
