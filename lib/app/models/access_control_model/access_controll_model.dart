
class AccessControllResponseModel {
  final String? name;
  final String? requestKey;

  AccessControllResponseModel({
    this.name,
    this.requestKey,
  });

  factory AccessControllResponseModel.fromJson(Map<String, dynamic> json) => AccessControllResponseModel(
    name: json["name"],
    requestKey: json["requestKey"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "requestKey": requestKey,
  };
}
