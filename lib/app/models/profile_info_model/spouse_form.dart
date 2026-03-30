import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/app/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/app/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/core/services/file_picker_util.dart';

class SpouseForm {
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
}
