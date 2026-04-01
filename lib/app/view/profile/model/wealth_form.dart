import 'package:al_wasyeah/app/core/services/picker/file_picker_service.dart';
import 'package:al_wasyeah/app/view/profile/model/wealth_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:al_wasyeah/app/view/profile/model/document_type_form.dart';

class WealthForm {
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

  void dispose() {
    // documentType.dispose();
    landArea.dispose();
    location.dispose();
    note.dispose();
  }
}
