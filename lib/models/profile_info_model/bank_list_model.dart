// To parse this JSON data, do
//
//     final bankListModel = bankListModelFromJson(jsonString);

import 'dart:convert';

List<BankModel> bankListModelFromJson(String str) =>
    List<BankModel>.from(json.decode(str).map((x) => BankModel.fromJson(x)));

String bankListModelToJson(List<BankModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BankModel {
  final String? bankBn;
  final String? bankEn;
  final String? bankId;

  BankModel({
    this.bankBn,
    this.bankEn,
    this.bankId,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        bankBn: json["bankBn"],
        bankEn: json["bankEn"],
        bankId: json["bankId"],
      );

  Map<String, dynamic> toJson() => {
        "bankBn": bankBn,
        "bankEn": bankEn,
        "bankId": bankId,
      };
}
