
class GetWitnessResponseModel {
  final String? requestKey;
  final dynamic relation;
  final DateTime? wnDate;
  final String? name;
  final String? mobile;
  final String? email;
  final String? maritalStatus;
  final String? profession;
  final String? fatherName;
  final String? motherName;

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
  });

  factory GetWitnessResponseModel.fromJson(Map<String, dynamic> json) => GetWitnessResponseModel(
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
  );

  Map<String, dynamic> toJson() => {
    "requestKey": requestKey,
    "relation": relation,
    "wnDate": "${wnDate!.year.toString().padLeft(4, '0')}-${wnDate!.month.toString().padLeft(2, '0')}-${wnDate!.day.toString().padLeft(2, '0')}",
    "name": name,
    "mobile": mobile,
    "email": email,
    "maritalStatus": maritalStatus,
    "profession": profession,
    "fatherName": fatherName,
    "motherName": motherName,
  };
}
