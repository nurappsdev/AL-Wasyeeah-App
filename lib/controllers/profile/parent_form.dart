import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/helpers/file_picker_util.dart';

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

  void dispose() {
    fatherName.dispose();
    fatherPassOrNID.dispose();
    motherName.dispose();
    motherPassOrNID.dispose();
  }
}
