// To parse this JSON data, do
//
//     final relevantList = relevantListFromJson(jsonString);

import 'dart:convert';

List<RelevantList> relevantListFromJson(String str) => List<RelevantList>.from(
    json.decode(str).map((x) => RelevantList.fromJson(x)));

String relevantListToJson(List<RelevantList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RelevantList {
  final String? encrypted;
  final String? relative;

  RelevantList({
    this.encrypted,
    this.relative,
  });

  factory RelevantList.fromJson(Map<String, dynamic> json) => RelevantList(
        encrypted: json["ENCRYPTED"],
        relative: json["RELATIVE"],
      );

  Map<String, dynamic> toJson() => {
        "ENCRYPTED": encrypted,
        "RELATIVE": relative,
      };
}
