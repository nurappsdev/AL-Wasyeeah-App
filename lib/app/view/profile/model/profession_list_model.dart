import 'dart:convert';

List<ProfessionModel> professionListFromJson(String str) =>
    List<ProfessionModel>.from(
        json.decode(str).map((x) => ProfessionModel.fromJson(x)));

String professionListToJson(List<ProfessionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfessionModel {
  String? profession;
  int? professionId;

  ProfessionModel({
    this.profession,
    this.professionId,
  });

  factory ProfessionModel.fromJson(Map<String, dynamic> json) =>
      ProfessionModel(
        profession: json["profession"],
        professionId: json["professionId"],
      );

  Map<String, dynamic> toJson() => {
        "profession": profession,
        "professionId": professionId,
      };

  ProfessionModel copyWith({
    String? profession,
    int? professionId,
  }) {
    return ProfessionModel(
      profession: profession ?? this.profession,
      professionId: professionId ?? this.professionId,
    );
  }
}
