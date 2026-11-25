import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wasiyyat/app/view/profile/model/profession_list_model.dart';
import 'package:wasiyyat/app/view/profile/model/country_list_model.dart';
import 'package:wasiyyat/app/view/profile/model/gender_list_model.dart';
import 'package:wasiyyat/app/core/services/picker/file_picker_service.dart';
import 'package:wasiyyat/app/view/profile/model/profile_model.dart';

class SiblingForm {
  SiblingInfo? original;
  final TextEditingController name = TextEditingController();
  final TextEditingController nid = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController email = TextEditingController();

  // Reactive state
  final Rxn<ProfessionModel> profession = Rxn<ProfessionModel>();
  final Rxn<CountryModel> nationality = Rxn<CountryModel>();
  final Rxn<GenderModel> gender = Rxn<GenderModel>();
  final RxBool isAlive = true.obs;

  // Date of Birth
  final Rx<DateTime?> selectedDob = Rx<DateTime?>(null);

  // File Picker State
  final Rxn<PickedFileResult> selectedNidFile = Rxn<PickedFileResult>();

  // Download State
  final RxBool isDownloadingNid = false.obs;
  final RxDouble nidDownloadProgress = 0.0.obs;

  // Existing URLs (for download)
  String? nidUrl;

  void dispose() {
    name.dispose();
    nid.dispose();
    mobile.dispose();
    email.dispose();
  }

  SiblingForm copy() {
    final newForm = SiblingForm();
    newForm.name.text = name.text;
    newForm.nid.text = nid.text;
    newForm.mobile.text = mobile.text;
    newForm.email.text = email.text;
    newForm.profession.value = profession.value;
    newForm.nationality.value = nationality.value;
    newForm.gender.value = gender.value;
    newForm.isAlive.value = isAlive.value;
    newForm.selectedDob.value = selectedDob.value;
    newForm.selectedNidFile.value = selectedNidFile.value;
    newForm.nidUrl = nidUrl;
    newForm.original = original;
    return newForm;
  }
}
