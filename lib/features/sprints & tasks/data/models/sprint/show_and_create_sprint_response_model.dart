import 'dart:convert';

import 'package:two_dashboard/features/sprints%20&%20tasks/data/models/sprint/sprint_model.dart';

CreateAndShowSprintResponseModel createAndShowSprintResponseModelFromJson(
  String str,
) => CreateAndShowSprintResponseModel.fromJson(json.decode(str));

String createAndShowSprintResponseModelToJson(
  CreateAndShowSprintResponseModel data,
) => json.encode(data.toJson());

class CreateAndShowSprintResponseModel {
  final int status;
  final String msg;
  final SprintModel data;

  CreateAndShowSprintResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory CreateAndShowSprintResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => CreateAndShowSprintResponseModel(
    status: json["status"],
    msg: json["msg"],
    data: SprintModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}
