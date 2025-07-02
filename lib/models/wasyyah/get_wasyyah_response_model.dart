
class GetWasyyahResponseModel {
   int? orderSeq;
  final String? title;
   String? visible;
   String? requestKey;
  final String? content;

  GetWasyyahResponseModel({
    this.orderSeq,
    this.title,
    this.visible,
    this.requestKey,
    this.content,
  });

  factory GetWasyyahResponseModel.fromJson(Map<String, dynamic> json) => GetWasyyahResponseModel(
    orderSeq: json["orderSeq"],
    title: json["title"],
    visible: json["visible"],
    requestKey: json["requestKey"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "orderSeq": orderSeq,
    "title": title,
    "visible": visible,
    "requestKey": requestKey,
    "content": content,
  };
}
