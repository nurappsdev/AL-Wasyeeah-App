import 'dart:convert';

List<MaritalListModel> maritalListModelFromJson(String str) => List<MaritalListModel>.from(json.decode(str).map((x) => MaritalListModel.fromJson(x)));

String maritalListModelToJson(List<MaritalListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaritalListModel {
    String? maritalType;
    int? maritalId;

    MaritalListModel({
        this.maritalType,
        this.maritalId,
    });

    factory MaritalListModel.fromJson(Map<String, dynamic> json) => MaritalListModel(
        maritalType: json["maritalType"],
        maritalId: json["maritalId"],
    );

    Map<String, dynamic> toJson() => {
        "maritalType": maritalType,
        "maritalId": maritalId,
    };
}
