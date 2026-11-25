import 'package:wasiyyat/app/core/services/picker/file_picker_service.dart';
import 'package:wasiyyat/app/view/profile/model/wealth_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wasiyyat/app/view/profile/model/profile_model.dart';

import 'package:wasiyyat/app/view/profile/model/document_type_form.dart';

class WealthForm {
  WealthInfo? original;
  // int? wealthId;
  // int? userId;

  final Rxn<WealthModel> wealth = Rxn<WealthModel>();
  // Replaced text controller with dropdown selection
  // final TextEditingController documentType = TextEditingController();
  final Rxn<DocumentTypeForm> selectedDocumentType = Rxn<DocumentTypeForm>();
  final RxList<DocumentTypeForm> documentTypeList = <DocumentTypeForm>[].obs;

  final TextEditingController landArea = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController note = TextEditingController();

  final Rxn<PickedFileResult> documentFile = Rxn<PickedFileResult>();
  String? documentUrl;

  //WealthForm({this.wealthId, this.userId});

  void dispose() {
    // documentType.dispose();
    landArea.dispose();
    location.dispose();
    note.dispose();
  }

  WealthForm copy() {
    final newForm = WealthForm();
    newForm.original = original;
    newForm.wealth.value = wealth.value;
    newForm.selectedDocumentType.value = selectedDocumentType.value;
    newForm.documentTypeList.assignAll(documentTypeList);
    newForm.landArea.text = landArea.text;
    newForm.location.text = location.text;
    newForm.note.text = note.text;
    newForm.documentFile.value = documentFile.value;
    newForm.documentUrl = documentUrl;
    return newForm;
  }
}
