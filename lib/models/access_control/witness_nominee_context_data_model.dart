// To parse this JSON data, do
//
//     final witnessNomineeContextDataModel = witnessNomineeContextDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:al_wasyeah/models/property_distribution_calculation_model/property_destribution_result_model.dart';

WitnessNomineeContextDataModel witnessNomineeContextDataModelFromJson(
        String str) =>
    WitnessNomineeContextDataModel.fromJson(json.decode(str));

String witnessNomineeContextDataModelToJson(
        WitnessNomineeContextDataModel data) =>
    json.encode(data.toJson());

class WitnessNomineeContextDataModel {
  Zakat? zakat;
  List<PropertydistributionResultModel>? propertyResult;

  WitnessNomineeContextDataModel({
    this.zakat,
    this.propertyResult,
  });

  factory WitnessNomineeContextDataModel.fromJson(Map<String, dynamic> json) =>
      WitnessNomineeContextDataModel(
        zakat: json["zakat"] == null ? null : Zakat.fromJson(json["zakat"]),
        propertyResult: json["propertyResult"] == null
            ? null
            : List<PropertydistributionResultModel>.from(
                jsonDecode(json["propertyResult"]).map(
                    (x) => PropertydistributionResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "zakat": zakat?.toJson(),
        "propertyResult": propertyResult?.map((x) => x.toJson()).toList(),
      };
}

class Zakat {
  double? zakatAmount;
  double? totalAsset;
  DateTime? lastCalculate;
  String? currencyCode;

  Zakat({
    this.zakatAmount,
    this.totalAsset,
    this.lastCalculate,
    this.currencyCode,
  });

  factory Zakat.fromJson(Map<String, dynamic> json) => Zakat(
        zakatAmount: json["zakatAmount"]?.toDouble(),
        totalAsset: json["totalAsset"]?.toDouble(),
        lastCalculate: json["lastCalculate"] == null
            ? null
            : DateTime.parse(json["lastCalculate"]),
        currencyCode: json["currencyCode"],
      );

  Map<String, dynamic> toJson() => {
        "zakatAmount": zakatAmount,
        "totalAsset": totalAsset,
        "lastCalculate": lastCalculate?.toIso8601String(),
        "currencyCode": currencyCode,
      };
}
