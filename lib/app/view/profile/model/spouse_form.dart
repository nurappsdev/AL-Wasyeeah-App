import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wasiyyat/app/view/profile/model/profession_list_model.dart';
import 'package:wasiyyat/app/view/profile/model/country_list_model.dart';
import 'package:wasiyyat/app/core/services/picker/file_picker_service.dart';
import 'package:wasiyyat/app/view/profile/model/profile_model.dart';

class SpouseForm {
  SpouseInfo? original;
  final RxBool isAlive = true.obs;
  final TextEditingController name = TextEditingController();
  final TextEditingController nid = TextEditingController();
  final TextEditingController passport = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController email = TextEditingController();

  final Rxn<ProfessionModel> profession = Rxn<ProfessionModel>();
  final Rxn<CountryModel> nationality = Rxn<CountryModel>();

  // Date of Birth
  final Rx<DateTime?> selectedDob = Rx<DateTime?>(null);

  // File Pickers
  final Rxn<PickedFileResult> selectedNidFile = Rxn<PickedFileResult>();
  final Rxn<PickedFileResult> selectedPassportFile = Rxn<PickedFileResult>();

  // URLs from API
  String? nidUrl;
  String? passportUrl;

  void dispose() {
    name.dispose();
    nid.dispose();
    passport.dispose();
    mobile.dispose();
    email.dispose();
  }

  SpouseForm copy() {
    final newForm = SpouseForm();
    newForm.isAlive.value = isAlive.value;
    newForm.name.text = name.text;
    newForm.nid.text = nid.text;
    newForm.passport.text = passport.text;
    newForm.mobile.text = mobile.text;
    newForm.email.text = email.text;
    newForm.profession.value = profession.value;
    newForm.nationality.value = nationality.value;
    newForm.selectedDob.value = selectedDob.value;
    newForm.selectedNidFile.value = selectedNidFile.value;
    newForm.selectedPassportFile.value = selectedPassportFile.value;
    newForm.nidUrl = nidUrl;
    newForm.passportUrl = passportUrl;
    newForm.original = original;
    return newForm;
  }
}
