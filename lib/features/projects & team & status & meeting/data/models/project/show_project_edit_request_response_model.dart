import 'dart:convert';

ShowProjectsEditRequestResponseModel
showProjectsEditRequestResponseModelFromJson(String str) =>
    ShowProjectsEditRequestResponseModel.fromJson(json.decode(str));

String showProjectsEditRequestResponseModelToJson(
  ShowProjectsEditRequestResponseModel data,
) => json.encode(data.toJson());

class ShowProjectsEditRequestResponseModel {
  final int status;
  final String msg;
  final List<MessageModel> data;

  ShowProjectsEditRequestResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory ShowProjectsEditRequestResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => ShowProjectsEditRequestResponseModel(
    status: json["status"],
    msg: json["msg"],
    data: List<MessageModel>.from(
      json["data"].map((x) => MessageModel.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class MessageModel {
  final String message;

  MessageModel({required this.message});

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      MessageModel(message: json["message"]);

  Map<String, dynamic> toJson() => {"message": message};
}
