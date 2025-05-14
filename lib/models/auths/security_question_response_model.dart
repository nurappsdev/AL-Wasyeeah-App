
class SecurityQuestionResponseModel {
  final int? questionId;
  final String? questionText;

  SecurityQuestionResponseModel({
    this.questionId,
    this.questionText,
  });

  factory SecurityQuestionResponseModel.fromJson(Map<String, dynamic> json) => SecurityQuestionResponseModel(
    questionId: json["questionId"],
    questionText: json["questionText"],
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "questionText": questionText,
  };
}
