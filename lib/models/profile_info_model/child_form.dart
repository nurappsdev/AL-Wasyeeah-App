import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/gender_list_model.dart';
import 'package:al_wasyeah/helpers/file_picker_util.dart';

class ChildForm {
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
}
