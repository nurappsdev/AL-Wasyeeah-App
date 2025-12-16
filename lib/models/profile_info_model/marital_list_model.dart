import 'dart:convert';

List<MaritalModel> maritalListModelFromJson(String str) =>
    List<MaritalModel>.from(
        json.decode(str).map((x) => MaritalModel.fromJson(x)));

String maritalListModelToJson(List<MaritalModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaritalModel {
  String? maritalType;
  int? maritalId;

  MaritalModel({
    this.maritalType,
    this.maritalId,
  });

  factory MaritalModel.fromJson(Map<String, dynamic> json) => MaritalModel(
        maritalType: json["maritalType"],
        maritalId: json["maritalId"],
      );

  Map<String, dynamic> toJson() => {
        "maritalType": maritalType,
        "maritalId": maritalId,
      };
}
