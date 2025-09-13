
class GetNisabRatesResponseModel {
  final int? id;
  final String? currencyCode;
  final double? nisabAmount;
  final String? currencyIcon;
  final String? activeYn;
  final int? insertBy;
  final DateTime? insertAt;
  final int? updateBy;
  final DateTime? updateAt;

  GetNisabRatesResponseModel({
    this.id,
    this.currencyCode,
    this.nisabAmount,
    this.currencyIcon,
    this.activeYn,
    this.insertBy,
    this.insertAt,
    this.updateBy,
    this.updateAt,
  });

  factory GetNisabRatesResponseModel.fromJson(Map<String, dynamic> json) => GetNisabRatesResponseModel(
    id: json["id"],
    currencyCode: json["currencyCode"],
    nisabAmount: json["nisabAmount"],
    currencyIcon: json["currencyIcon"],
    activeYn: json["activeYn"],
    insertBy: json["insertBy"],
    insertAt: json["insertAt"] == null ? null : DateTime.parse(json["insertAt"]),
    updateBy: json["updateBy"],
    updateAt: json["updateAt"] == null ? null : DateTime.parse(json["updateAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "currencyCode": currencyCode,
    "nisabAmount": nisabAmount,
    "currencyIcon": currencyIcon,
    "activeYn": activeYn,
    "insertBy": insertBy,
    "insertAt": insertAt?.toIso8601String(),
    "updateBy": updateBy,
    "updateAt": updateAt?.toIso8601String(),
  };
}
