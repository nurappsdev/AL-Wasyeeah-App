
class SelectFeatureModel {
  final String? name;
  final int? key;

  SelectFeatureModel({
    this.name,
    this.key,
  });

  factory SelectFeatureModel.fromJson(Map<String, dynamic> json) => SelectFeatureModel(
    name: json["name"],
    key: json["key"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "key": key,
  };
}
