
class GetAccessFeatureModel {
  final String? contextName;
  final int? id;

  GetAccessFeatureModel({
    this.contextName,
    this.id,
  });

  factory GetAccessFeatureModel.fromJson(Map<String, dynamic> json) => GetAccessFeatureModel(
    contextName: json["contextName"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "contextName": contextName,
    "id": id,
  };
}
