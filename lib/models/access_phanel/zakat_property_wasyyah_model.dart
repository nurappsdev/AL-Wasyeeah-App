

class ZakatPropertyWasiyyahModel {
  final Zakat? zakat;
  final String? propertyResult;
  final List<WasiyyahContent>? wasiyyahContent;

  ZakatPropertyWasiyyahModel({
    this.zakat,
    this.propertyResult,
    this.wasiyyahContent,
  });

  factory ZakatPropertyWasiyyahModel.fromJson(Map<String, dynamic> json) => ZakatPropertyWasiyyahModel(
    zakat: json["zakat"] == null ? null : Zakat.fromJson(json["zakat"]),
    propertyResult: json["propertyResult"],
    wasiyyahContent: json["wasiyyahContent"] == null ? [] : List<WasiyyahContent>.from(json["wasiyyahContent"]!.map((x) => WasiyyahContent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "zakat": zakat?.toJson(),
    "propertyResult": propertyResult,
    "wasiyyahContent": wasiyyahContent == null ? [] : List<dynamic>.from(wasiyyahContent!.map((x) => x.toJson())),
  };
}

class WasiyyahContent {
  final int? orderSeq;
  final String? requestKey;
  final String? content;
  final String? visible;
  final String? title;

  WasiyyahContent({
    this.orderSeq,
    this.requestKey,
    this.content,
    this.visible,
    this.title,
  });

  factory WasiyyahContent.fromJson(Map<String, dynamic> json) => WasiyyahContent(
    orderSeq: json["orderSeq"],
    requestKey: json["requestKey"],
    content: json["content"],
    visible: json["visible"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "orderSeq": orderSeq,
    "requestKey": requestKey,
    "content": content,
    "visible": visible,
    "title": title,
  };
}

class Zakat {
  final int? zakatAmount;
  final int? totalAsset;
  final DateTime? lastCalculate;
  final String? currencyCode;

  Zakat({
    this.zakatAmount,
    this.totalAsset,
    this.lastCalculate,
    this.currencyCode,
  });

  factory Zakat.fromJson(Map<String, dynamic> json) => Zakat(
    zakatAmount: json["zakatAmount"],
    totalAsset: json["totalAsset"],
    lastCalculate: json["lastCalculate"] == null ? null : DateTime.parse(json["lastCalculate"]),
    currencyCode: json["currencyCode"],
  );

  Map<String, dynamic> toJson() => {
    "zakatAmount": zakatAmount,
    "totalAsset": totalAsset,
    "lastCalculate": lastCalculate?.toIso8601String(),
    "currencyCode": currencyCode,
  };
}

