import 'dart:convert';

List<GetWitnessResponseModel> getWitnessResponseModelFromJson(String str) =>
    List<GetWitnessResponseModel>.from(
        json.decode(str).map((x) => GetWitnessResponseModel.fromJson(x)));

String getWitnessResponseModelToJson(List<GetWitnessResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetWitnessResponseModel {
  final String? requestKey;
  final dynamic relation;
  final DateTime? wnDate;
  final String? name;
  final String? mobile;
  final String? email;
  final dynamic maritalStatus;
  final dynamic profession;
  final dynamic fatherName;
  final dynamic motherName;
  final dynamic imageUrl;
  final dynamic registered;
  final dynamic note;

  GetWitnessResponseModel({
    this.requestKey,
    this.relation,
    this.wnDate,
    this.name,
    this.mobile,
    this.email,
    this.maritalStatus,
    this.profession,
    this.fatherName,
    this.motherName,
    this.imageUrl,
    this.registered,
    this.note,
  });

  factory GetWitnessResponseModel.fromJson(Map<String, dynamic> json) =>
      GetWitnessResponseModel(
        requestKey: json["requestKey"],
        relation: json["relation"],
        wnDate: json["wnDate"] == null ? null : DateTime.parse(json["wnDate"]),
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        maritalStatus: json["maritalStatus"],
        profession: json["profession"],
        fatherName: json["fatherName"],
        motherName: json["motherName"],
        imageUrl: json["imageUrl"],
        registered: json["registered"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "requestKey": requestKey,
        "relation": relation,
        "wnDate":
            "${wnDate!.year.toString().padLeft(4, '0')}-${wnDate!.month.toString().padLeft(2, '0')}-${wnDate!.day.toString().padLeft(2, '0')}",
        "name": name,
        "mobile": mobile,
        "email": email,
        "maritalStatus": maritalStatus,
        "profession": profession,
        "fatherName": fatherName,
        "motherName": motherName,
        "imageUrl": imageUrl,
        "registered": registered,
        "note": note,
      };
}
