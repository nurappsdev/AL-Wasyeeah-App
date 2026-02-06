import 'dart:convert';

List<BranchModel> branchListModelFromJson(String str) => List<BranchModel>.from(
    json.decode(str).map((x) => BranchModel.fromJson(x)));

String brancListhModelToJson(List<BranchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BranchModel {
  final String? branchId;
  final String? branchNameEn;
  final String? branchNameBn;

  BranchModel({
    this.branchId,
    this.branchNameEn,
    this.branchNameBn,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
        branchId: json["branchId"],
        branchNameEn: json["branchNameEn"],
        branchNameBn: json["branchNameBn"],
      );

  Map<String, dynamic> toJson() => {
        "branchId": branchId,
        "branchNameEn": branchNameEn,
        "branchNameBn": branchNameBn,
      };
}

