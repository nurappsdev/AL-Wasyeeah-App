
class NomineeResponseModel {
  final String? requestKey;
  final String? name;
  final String? permanentAddress;
  final String? presentAddress;
  final String? relation;
  final String? email;
  final String? mobile;
  NomineeResponseModel({
    this.requestKey,
    this.name,
    this.permanentAddress,
    this.presentAddress,
    this.relation,
    this.email,
    this.mobile,
  });

  factory NomineeResponseModel.fromJson(Map<String, dynamic> json) => NomineeResponseModel(
    requestKey: json["requestKey"],
    name: json["name"],
    permanentAddress: json["permanentAddress"],
    presentAddress: json["presentAddress"],
    relation: json["relation"],
    email: json["email"],
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "requestKey": requestKey,
    "name": name,
    "permanentAddress": permanentAddress,
    "presentAddress": presentAddress,
    "relation": relation,
    "email": email,
    "mobile": mobile,
  };

}
