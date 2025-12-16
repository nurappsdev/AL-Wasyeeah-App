// To parse this JSON data, do
//
//     final genderListModel = genderListModelFromJson(jsonString);

import 'dart:convert';

List<GenderModel> genderListModelFromJson(String str) => List<GenderModel>.from(
    json.decode(str).map((x) => GenderModel.fromJson(x)));

String genderListModelToJson(List<GenderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GenderModel {
  final int? genderId;
  final String? gender;

  GenderModel({
    this.genderId,
    this.gender,
  });

  factory GenderModel.fromJson(Map<String, dynamic> json) => GenderModel(
        genderId: json["genderId"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "genderId": genderId,
        "gender": gender,
      };
}
