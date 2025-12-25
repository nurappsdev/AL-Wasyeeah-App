import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/helpers/file_picker_util.dart';

class SpouseForm {
  final int? spouseId;
  final int? userId;
  final bool? existing;

  final TextEditingController name = TextEditingController();
  final TextEditingController nid = TextEditingController();
  final TextEditingController passport = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController email = TextEditingController();

  final Rxn<ProfessionModel> profession = Rxn<ProfessionModel>();
  final Rxn<CountryModel> nationality = Rxn<CountryModel>();
  final RxBool isAlive = true.obs;

  // File Pickers
  final Rxn<PickedFileResult> selectedNidFile = Rxn<PickedFileResult>();
  final Rxn<PickedFileResult> selectedPassportFile = Rxn<PickedFileResult>();

  // Download State
  final RxBool isDownloadingNid = false.obs;
  final RxDouble nidDownloadProgress = 0.0.obs;

  final RxBool isDownloadingPassport = false.obs;
  final RxDouble passportDownloadProgress = 0.0.obs;

  // URLs from API
  String? nidUrl;
  String? passportUrl;

  SpouseForm({
    this.spouseId,
    this.userId,
    this.existing,
    String? nameVal,
    String? nidVal,
    String? passportVal,
    String? mobileVal,
    String? emailVal,
    this.nidUrl,
    this.passportUrl,
    bool isAliveVal = true,
  }) {
    name.text = nameVal ?? '';
    nid.text = nidVal ?? '';
    passport.text = passportVal ?? '';
    mobile.text = mobileVal ?? '';
    email.text = emailVal ?? '';
    isAlive.value = isAliveVal;
  }

  void dispose() {
    name.dispose();
    nid.dispose();
    passport.dispose();
    mobile.dispose();
    email.dispose();
  }
}
