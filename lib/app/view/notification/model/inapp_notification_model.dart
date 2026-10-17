// To parse this JSON data, do
//
//     final inAppNotificationModel = inAppNotificationModelFromJson(jsonString);

import 'dart:convert';

List<InAppNotificationModel> inAppNotificationModelFromJson(String str) =>
    List<InAppNotificationModel>.from(
        json.decode(str).map((x) => InAppNotificationModel.fromJson(x)));

String inAppNotificationModelToJson(List<InAppNotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InAppNotificationModel {
  final DateTime? generateAt;
  final String? requestKey;
  final String? message;
  final String? status;

  InAppNotificationModel({
    this.generateAt,
    this.requestKey,
    this.message,
    this.status,
  });

  factory InAppNotificationModel.fromJson(Map<String, dynamic> json) =>
      InAppNotificationModel(
        generateAt: json["generateAt"] == null
            ? null
            : DateTime.parse(json["generateAt"]),
        requestKey: json["requestKey"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "generateAt": generateAt?.toIso8601String(),
        "requestKey": requestKey,
        "message": message,
        "status": status,
      };
}
