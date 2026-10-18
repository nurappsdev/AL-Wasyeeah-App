import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wasiyyat/app/view/profile/model/marital_list_model.dart';
import 'package:wasiyyat/app/view/profile/model/profession_list_model.dart';
import 'package:wasiyyat/app/view/profile/model/country_list_model.dart';
import 'package:wasiyyat/app/view/profile/model/gender_list_model.dart';
import 'package:wasiyyat/app/core/services/picker/file_picker_service.dart';

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
  final Rxn<PickedFileResult> selectedProfilePictureFile =
      Rxn<PickedFileResult>();

  // Download State

  // Existing URLs (for download)
  String? nidUrl;
  String? tinUrl;
  String? multiCitizenUrl;
  String? profilePictureUrl;

  void clear() {
    firstName.clear();
    lastName.clear();
    district.clear();
    nid.clear();
    tin.clear();
    multiCitizenPassport.clear();

    selectedMarried.value = null;
    selectedProfession.value = null;
    selectedCountry.value = null;
    selectedMultiCitizenCountry.value = null;
    selectedGender.value = null;

    selectedNidFile.value = null;
    selectedTinFile.value = null;
    selectedMultiCitizenFile.value = null;
    selectedProfilePictureFile.value = null;

    nidUrl = null;
    tinUrl = null;
    multiCitizenUrl = null;
    profilePictureUrl = null;
  }

  void dispose() {
    firstName.dispose();
    lastName.dispose();
    district.dispose();
    nid.dispose();
    tin.dispose();
    multiCitizenPassport.dispose();
  }
}
