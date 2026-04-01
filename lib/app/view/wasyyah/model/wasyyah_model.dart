// To parse this JSON data, do
//
//     final getWasyyahResponseModel = getWasyyahResponseModelFromJson(jsonString);

import 'dart:convert';

List<WasyyahContentModel> getWasyyahResponseModelFromJson(String str) => List<WasyyahContentModel>.from(json.decode(str).map((x) => WasyyahContentModel.fromJson(x)));

String getWasyyahResponseModelToJson(List<WasyyahContentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WasyyahContentModel {
  int? orderSeq;
  String? requestKey;
  String? visible;
  String? title;
  String? content;

  WasyyahContentModel({
    this.orderSeq,
    this.requestKey,
    this.visible,
    this.title,
    this.content,
  });

  factory WasyyahContentModel.fromJson(Map<String, dynamic> json) => WasyyahContentModel(
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
