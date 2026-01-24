import 'package:al_wasyeah/helpers/file_picker_util.dart';
import 'package:al_wasyeah/models/profile_info_model/wealth_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WealthForm {
  final Rxn<WealthModel> wealth = Rxn<WealthModel>();
  final TextEditingController documentType = TextEditingController();
  final TextEditingController landArea = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController note = TextEditingController();

  final Rxn<PickedFileResult> documentFile = Rxn<PickedFileResult>();
  String? documentUrl;

  void dispose() {
    documentType.dispose();
    landArea.dispose();
    location.dispose();
    note.dispose();
  }
}
