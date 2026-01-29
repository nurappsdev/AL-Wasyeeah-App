// To parse this JSON data, do
//
//     final documentTypeForm = documentTypeFormFromJson(jsonString);

import 'dart:convert';

List<DocumentTypeForm> documentTypeListFromJson(String str) =>
    List<DocumentTypeForm>.from(
        json.decode(str).map((x) => DocumentTypeForm.fromJson(x)));

String documentTypeListToJson(List<DocumentTypeForm> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DocumentTypeForm {
  final String? amountLabel;
  final String? documentType;
  final int? documentTypeId;

  DocumentTypeForm({
    this.amountLabel,
    this.documentType,
    this.documentTypeId,
  });

  factory DocumentTypeForm.fromJson(Map<String, dynamic> json) =>
      DocumentTypeForm(
        amountLabel: json["amountLabel"],
        documentType: json["documentType"],
        documentTypeId: json["documentTypeId"],
      );

  Map<String, dynamic> toJson() => {
        "amountLabel": amountLabel,
        "documentType": documentType,
        "documentTypeId": documentTypeId,
      };
}
