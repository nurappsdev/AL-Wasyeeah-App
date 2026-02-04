// To parse this JSON data, do
//
//     final securityQuestionListModel = securityQuestionListModelFromJson(jsonString);

import 'dart:convert';

List<SecurityQuestionListModel> securityQuestionListModelFromJson(String str) =>
    List<SecurityQuestionListModel>.from(
        json.decode(str).map((x) => SecurityQuestionListModel.fromJson(x)));

String securityQuestionListModelToJson(List<SecurityQuestionListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SecurityQuestionListModel {
  final int? questionId;
  final String? questionText;

  SecurityQuestionListModel({
    this.questionId,
    this.questionText,
  });

  factory SecurityQuestionListModel.fromJson(Map<String, dynamic> json) =>
      SecurityQuestionListModel(
        questionId: json["questionId"],
        questionText: json["questionText"],
      );

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "questionText": questionText,
      };
}
