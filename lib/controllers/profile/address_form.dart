import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';

class AddressForm {
  // Present Address Controllers
  final TextEditingController presentZipCode = TextEditingController();
  final TextEditingController presentVillage = TextEditingController();
  final TextEditingController presentRoad = TextEditingController();

  // Permanent Address Controllers
  final TextEditingController permanentZipCode = TextEditingController();
  final TextEditingController permanentVillage = TextEditingController();
  final TextEditingController permanentRoad = TextEditingController();

  // Overseas Address Controllers
  final TextEditingController overseasVillage = TextEditingController();

  // Reactive State
  final Rxn<CountryModel> selectedOverseasCountry = Rxn<CountryModel>();
  final RxBool isPresentAddressAsPermanentAddress = false.obs;

  void dispose() {
    presentZipCode.dispose();
    presentVillage.dispose();
    presentRoad.dispose();
    permanentZipCode.dispose();
    permanentVillage.dispose();
    permanentRoad.dispose();
    overseasVillage.dispose();
  }
}
