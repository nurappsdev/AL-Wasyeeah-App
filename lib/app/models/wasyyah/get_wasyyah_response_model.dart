// To parse this JSON data, do
//
//     final getWasyyahResponseModel = getWasyyahResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetWasyyahResponseModel> getWasyyahResponseModelFromJson(String str) =>
    List<GetWasyyahResponseModel>.from(
        json.decode(str).map((x) => GetWasyyahResponseModel.fromJson(x)));

String getWasyyahResponseModelToJson(List<GetWasyyahResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetWasyyahResponseModel {
  int? orderSeq;
  String? requestKey;
  String? visible;
  String? title;
  String? content;

  GetWasyyahResponseModel({
    this.orderSeq,
    this.requestKey,
    this.visible,
    this.title,
    this.content,
  });

  factory GetWasyyahResponseModel.fromJson(Map<String, dynamic> json) =>
      GetWasyyahResponseModel(
        orderSeq: json["orderSeq"],
        requestKey: json["requestKey"],
        visible: json["visible"],
        title: json["title"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "orderSeq": orderSeq,
        "requestKey": requestKey,
        "visible": visible,
        "title": title,
        "content": content,
      };
}
