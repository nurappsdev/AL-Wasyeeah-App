// To parse this JSON data, do
//
//     final wealthListModel = wealthListModelFromJson(jsonString);

import 'dart:convert';

List<WealthModel> wealthListModelFromJson(String str) => List<WealthModel>.from(
    json.decode(str).map((x) => WealthModel.fromJson(x)));

String wealthListModelToJson(List<WealthModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WealthModel {
  final int? wealthId;
  final String? wealth;

  WealthModel({
    this.wealthId,
    this.wealth,
  });

  factory WealthModel.fromJson(Map<String, dynamic> json) => WealthModel(
        wealthId: json["wealthId"],
        wealth: json["wealth"],
      );

  Map<String, dynamic> toJson() => {
        "wealthId": wealthId,
        "wealth": wealth,
      };
}
