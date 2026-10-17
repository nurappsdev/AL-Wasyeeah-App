import 'dart:convert';

List<ContextModel> contextModelFromJson(String str) => List<ContextModel>.from(
    json.decode(str).map((x) => ContextModel.fromJson(x)));

String contextModelToJson(List<ContextModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContextModel {
  String? contextName;
  int? id;

  ContextModel({this.contextName, this.id});

  factory ContextModel.fromJson(Map<String, dynamic> json) {
    return ContextModel(
      contextName: json['contextName'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contextName': contextName,
      'id': id,
    };
  }
}
