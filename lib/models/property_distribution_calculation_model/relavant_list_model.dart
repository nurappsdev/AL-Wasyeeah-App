// To parse this JSON data, do
//
//     final relevantList = relevantListFromJson(jsonString);

import 'dart:convert';

List<RelativeModelForPropertyDistribution> relevantListFromJson(String str) =>
    List<RelativeModelForPropertyDistribution>.from(json
        .decode(str)
        .map((x) => RelativeModelForPropertyDistribution.fromJson(x)));

String relevantListToJson(List<RelativeModelForPropertyDistribution> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RelativeModelForPropertyDistribution {
  final String? encrypted;
  final String? relative;

  RelativeModelForPropertyDistribution({
    this.encrypted,
    this.relative,
  });

  factory RelativeModelForPropertyDistribution.fromJson(
          Map<String, dynamic> json) =>
      RelativeModelForPropertyDistribution(
        encrypted: json["ENCRYPTED"],
        relative: json["RELATIVE"],
      );

  Map<String, dynamic> toJson() => {
        "ENCRYPTED": encrypted,
        "RELATIVE": relative,
      };
}

