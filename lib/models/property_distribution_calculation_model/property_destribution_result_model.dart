// To parse this JSON data, do
//
//     final propertydistributionResultModel = propertydistributionResultModelFromJson(jsonString);

import 'dart:convert';

List<PropertydistributionResultModel> propertydistributionResultModelFromJson(
        String str) =>
    List<PropertydistributionResultModel>.from(json
        .decode(str)
        .map((x) => PropertydistributionResultModel.fromJson(x)));

String propertydistributionResultModelToJson(
        List<PropertydistributionResultModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PropertydistributionResultModel {
  final String? relativeName;
  final double? portionPart;
  final double? landPart;
  final double? goldPart;
  final double? silverPart;
  final int? currencyPart;

  PropertydistributionResultModel({
    this.relativeName,
    this.portionPart,
    this.landPart,
    this.goldPart,
    this.silverPart,
    this.currencyPart,
  });

  factory PropertydistributionResultModel.fromJson(Map<String, dynamic> json) =>
      PropertydistributionResultModel(
        relativeName: json["relative_name"],
        portionPart: json["portion_part"]?.toDouble(),
        landPart: json["land_part"]?.toDouble(),
        goldPart: json["gold_part"]?.toDouble(),
        silverPart: json["silver_part"]?.toDouble(),
        currencyPart: json["currency_part"],
      );

  Map<String, dynamic> toJson() => {
        "relative_name": relativeName,
        "portion_part": portionPart,
        "land_part": landPart,
        "gold_part": goldPart,
        "silver_part": silverPart,
        "currency_part": currencyPart,
      };
}

