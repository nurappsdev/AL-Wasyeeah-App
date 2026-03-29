import 'dart:convert';

List<AccessControlUserModel> accessControlUserModelFromJson(String str) =>
    List<AccessControlUserModel>.from(
        json.decode(str).map((x) => AccessControlUserModel.fromJson(x)));

String accessControlUserModelToJson(List<AccessControlUserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccessControlUserModel {
  String? requestKey;
  String? name;

  AccessControlUserModel({this.requestKey, this.name});

  factory AccessControlUserModel.fromJson(Map<String, dynamic> json) {
    return AccessControlUserModel(
      requestKey: json['requestKey'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestKey': requestKey,
      'name': name,
    };
  }
}
