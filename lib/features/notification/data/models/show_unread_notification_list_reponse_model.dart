import 'dart:convert';

import 'package:two_dashboard/features/notification/data/models/notification_model.dart';

ShowUnReadNotificationListResponseModel
showUnReadNotificationListResponseModelFromJson(String str) =>
    ShowUnReadNotificationListResponseModel.fromJson(json.decode(str));

String showUnReadNotificationListResponseModelToJson(
  ShowUnReadNotificationListResponseModel data,
) => json.encode(data.toJson());

class ShowUnReadNotificationListResponseModel {
  final int status;
  final String msg;
  final List<NotificationModel> data;

  ShowUnReadNotificationListResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory ShowUnReadNotificationListResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => ShowUnReadNotificationListResponseModel(
    status: json["status"],
    msg: json["msg"],
    data: List<NotificationModel>.from(
      json["data"].map((x) => NotificationModel.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
