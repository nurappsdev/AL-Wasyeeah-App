import 'package:al_wasyeah/core/services/file_picker_util.dart';
import 'package:al_wasyeah/app/models/profile_info_model/wealth_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:al_wasyeah/app/models/profile_info_model/document_type_form.dart';

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
