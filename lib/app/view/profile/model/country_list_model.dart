// To parse this JSON data, do
//
//     final countryListModel = countryListModelFromJson(jsonString);

import 'dart:convert';

List<CountryModel> countryListModelFromJson(String str) =>
    List<CountryModel>.from(
        json.decode(str).map((x) => CountryModel.fromJson(x)));

String countryListModelToJson(List<CountryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryModel {
  final String? countryCode;
  final String? country;
  final int? countryId;

  CountryModel({
    this.countryCode,
    this.country,
    this.countryId,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        countryCode: json["countryCode"],
        country: json["country"],
        countryId: json["countryId"],
      );

  Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "country": country,
        "countryId": countryId,
      };
}
