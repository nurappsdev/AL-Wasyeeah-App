
class NomineetedResponseModel {
  final dynamic requestKey;
  final dynamic relation;
  final dynamic wnDate;
  final String? name;
  final String? mobile;
  final String? email;
  final dynamic maritalStatus;
  final String? profession;
  final String? fatherName;
  final String? motherName;

  NomineetedResponseModel({
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

  factory NomineetedResponseModel.fromJson(Map<String, dynamic> json) => NomineetedResponseModel(
    requestKey: json["requestKey"],
    relation: json["relation"],
    wnDate: json["wnDate"],
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
    "wnDate": wnDate,
    "name": name,
    "mobile": mobile,
    "email": email,
    "maritalStatus": maritalStatus,
    "profession": profession,
    "fatherName": fatherName,
    "motherName": motherName,
  };
}
