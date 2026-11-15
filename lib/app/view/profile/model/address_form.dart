import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wasiyyat/app/view/profile/model/country_list_model.dart';

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

  void clear() {
    presentZipCode.clear();
    presentVillage.clear();
    presentRoad.clear();
    permanentZipCode.clear();
    permanentVillage.clear();
    permanentRoad.clear();
    overseasVillage.clear();
    selectedOverseasCountry.value = null;
    isPresentAddressAsPermanentAddress.value = false;
  }

  void dispose() {
    presentZipCode.dispose();
    presentVillage.dispose();
    presentRoad.dispose();
    permanentZipCode.dispose();
    permanentVillage.dispose();
    permanentRoad.dispose();
    overseasVillage.dispose();
  }

  AddressForm copy() {
    final newForm = AddressForm();
    newForm.presentZipCode.text = presentZipCode.text;
    newForm.presentVillage.text = presentVillage.text;
    newForm.presentRoad.text = presentRoad.text;
    newForm.permanentZipCode.text = permanentZipCode.text;
    newForm.permanentVillage.text = permanentVillage.text;
    newForm.permanentRoad.text = permanentRoad.text;
    newForm.overseasVillage.text = overseasVillage.text;
    newForm.selectedOverseasCountry.value = selectedOverseasCountry.value;
    newForm.isPresentAddressAsPermanentAddress.value =
        isPresentAddressAsPermanentAddress.value;
    return newForm;
  }
}
