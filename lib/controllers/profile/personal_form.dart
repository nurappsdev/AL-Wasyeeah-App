import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/models/profile_info_model/marital_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/gender_list_model.dart';
import 'package:al_wasyeah/helpers/file_picker_util.dart';

class PersonalForm {
  // Text Controllers
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController district = TextEditingController();
  final TextEditingController nid = TextEditingController();
  final TextEditingController tin = TextEditingController();
  final TextEditingController multiCitizenPassport = TextEditingController();

  // Reactive State
  final Rxn<MaritalModel> selectedMarried = Rxn<MaritalModel>();
  final Rxn<ProfessionModel> selectedProfession = Rxn<ProfessionModel>();
  final Rxn<CountryModel> selectedCountry = Rxn<CountryModel>();
  final Rxn<CountryModel> selectedMultiCitizenCountry = Rxn<CountryModel>();
  final Rxn<GenderModel> selectedGender = Rxn<GenderModel>();

  // File Picker State
  final Rxn<PickedFileResult> selectedNidFile = Rxn<PickedFileResult>();
  final Rxn<PickedFileResult> selectedTinFile = Rxn<PickedFileResult>();
  final Rxn<PickedFileResult> selectedMultiCitizenFile =
      Rxn<PickedFileResult>();

  // Download State

  // Existing URLs (for download)
  String? nidUrl;
  String? tinUrl;
  String? multiCitizenUrl;

  void dispose() {
    firstName.dispose();
    lastName.dispose();
    district.dispose();
    nid.dispose();
    tin.dispose();
    multiCitizenPassport.dispose();
  }
}
