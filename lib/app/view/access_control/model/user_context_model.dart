import 'dart:convert';

List<UserContextModel> userContextModelFromJson(String str) =>
    List<UserContextModel>.from(
        json.decode(str).map((x) => UserContextModel.fromJson(x)));

String userContextModelToJson(List<UserContextModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserContextModel {
  String? name;
  int? key;

  UserContextModel({this.name, this.key});

  factory UserContextModel.fromJson(Map<String, dynamic> json) {
    return UserContextModel(
      name: json['name'],
      key: json['key'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'key': key,
    };
  }
}
