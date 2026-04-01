// To parse this JSON data, do
//
//     final witnessNomineeContextDataModel = witnessNomineeContextDataModelFromJson(jsonString);

import 'dart:convert';
import 'package:al_wasyeah/app/view/property_distribution_calculation/model/property_destribution_result_model.dart';
import 'package:al_wasyeah/app/view/wasyyah/model/wasyyah_model.dart';

WitnessNomineeContextDataModel witnessNomineeContextDataModelFromJson(String str) => WitnessNomineeContextDataModel.fromJson(json.decode(str));

String witnessNomineeContextDataModelToJson(WitnessNomineeContextDataModel data) => json.encode(data.toJson());

class WitnessNomineeContextDataModel {
  Zakat? zakat;
  List<PropertydistributionResultModel>? propertyResult;
  List<WasyyahContentModel>? wasiyaaContent;

  WitnessNomineeContextDataModel({
    this.zakat,
    this.propertyResult,
    this.wasiyaaContent,
  });

  factory WitnessNomineeContextDataModel.fromJson(Map<String, dynamic> json) => WitnessNomineeContextDataModel(
        zakat: json["zakat"] == null ? null : Zakat.fromJson(json["zakat"]),
        propertyResult: json["propertyResult"] == null ? null : List<PropertydistributionResultModel>.from(jsonDecode(json["propertyResult"]).map((x) => PropertydistributionResultModel.fromJson(x))),
        wasiyaaContent: json['wasiyyahContent'] == null ? null : List<WasyyahContentModel>.from(json["wasiyyahContent"].map((x)=> WasyyahContentModel.fromJson(x))),
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
        lastCalculate: json["lastCalculate"] == null ? null : DateTime.parse(json["lastCalculate"]),
        currencyCode: json["currencyCode"],
      );

  Map<String, dynamic> toJson() => {
        "zakatAmount": zakatAmount,
        "totalAsset": totalAsset,
        "lastCalculate": lastCalculate?.toIso8601String(),
        "currencyCode": currencyCode,
      };
}
