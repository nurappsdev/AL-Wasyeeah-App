
class SearchAsignResponseModel {
  final dynamic requestKey;
  final String? relation;
  final dynamic wnDate;
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

  SearchAsignResponseModel({
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

  factory SearchAsignResponseModel.fromJson(Map<String, dynamic> json) => SearchAsignResponseModel(
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
    imageUrl: json["imageUrl"],
    registered: json["registered"],
    note: json["note"],
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
    "imageUrl": imageUrl,
    "registered": registered,
    "note": note,
  };
}
