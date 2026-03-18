// To parse this JSON data, do
//
//     final zakatCalculationResultModel = zakatCalculationResultModelFromJson(jsonString);

import 'dart:convert';

ZakatCalculationResultModel zakatCalculationResultModelFromJson(String str) => ZakatCalculationResultModel.fromJson(json.decode(str));

String zakatCalculationResultModelToJson(ZakatCalculationResultModel data) => json.encode(data.toJson());

class ZakatCalculationResultModel {
  final double? zakatAmount;
  final double? netAssets;

  ZakatCalculationResultModel({
    this.zakatAmount,
    this.netAssets,
  });

  factory ZakatCalculationResultModel.fromJson(Map<String, dynamic> json) => ZakatCalculationResultModel(
        zakatAmount: json["zakatAmount"],
        netAssets: json["netAssets"],
      );

  Map<String, dynamic> toJson() => {
        "zakatAmount": zakatAmount,
        "netAssets": netAssets,
      };
}
