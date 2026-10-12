import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/app/view/profile/model/profession_list_model.dart';
import 'package:al_wasyeah/app/view/profile/model/country_list_model.dart';
import 'package:al_wasyeah/app/core/services/picker/file_picker_service.dart';

class ParentForm {
  // Father Information
  final TextEditingController fatherName = TextEditingController();
  final TextEditingController fatherPassOrNID = TextEditingController();
  final Rxn<ProfessionModel> selectedFatherProfession = Rxn<ProfessionModel>();
  final Rxn<CountryModel> selectedFatherCountry = Rxn<CountryModel>();
  final RxBool isFatherAlive = false.obs;

  // Mother Information
  final TextEditingController motherName = TextEditingController();
  final TextEditingController motherPassOrNID = TextEditingController();
  final Rxn<ProfessionModel> selectedMotherProfession = Rxn<ProfessionModel>();
  final Rxn<CountryModel> selectedMotherCountry = Rxn<CountryModel>();
  final RxBool isMotherAlive = false.obs;

  // File Picker State - Father
  final Rxn<PickedFileResult> selectedFatherFile = Rxn<PickedFileResult>();

  // File Picker State - Mother
  final Rxn<PickedFileResult> selectedMotherFile = Rxn<PickedFileResult>();

  // Existing URLs (for download)
  String? fatherNidUrl;
  String? motherNidUrl;

  void clear() {
    fatherName.clear();
    fatherPassOrNID.clear();
    selectedFatherProfession.value = null;
    selectedFatherCountry.value = null;
    isFatherAlive.value = false;
    selectedFatherFile.value = null;
    fatherNidUrl = null;

    motherName.clear();
    motherPassOrNID.clear();
    selectedMotherProfession.value = null;
    selectedMotherCountry.value = null;
    isMotherAlive.value = false;
    selectedMotherFile.value = null;
    motherNidUrl = null;
  }

  void dispose() {
    fatherName.dispose();
    fatherPassOrNID.dispose();
    motherName.dispose();
    motherPassOrNID.dispose();
  }
}
