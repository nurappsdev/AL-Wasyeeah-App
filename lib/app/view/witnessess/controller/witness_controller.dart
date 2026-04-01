import 'dart:convert';
import 'package:al_wasyeah/app/core/utils/toast_message.dart';
import 'package:al_wasyeah/app/view/wasiyyah/model/wasyyah_model.dart';
import 'package:al_wasyeah/app/view/witnessess/model/get_witness_response_model.dart';
import 'package:al_wasyeah/app/core/services/api/api_service.dart';
import 'package:al_wasyeah/app/core/utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/app/core/l10n/app_localizations.dart';
import 'package:al_wasyeah/app/view/witnessess/add_outside_witnesses_widget.dart';
import 'package:al_wasyeah/app/view/witnessess/add_witnesses_widget.dart';

class WitnessController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  /// For "Your Witness"
  final Rx<RxStatus> witnessStatus = Rx<RxStatus>(RxStatus.loading());

  /// For "I'm Witness"
  final Rx<RxStatus> witnessesYouStatus = Rx<RxStatus>(RxStatus.loading());

  final Rx<RxStatus> searchWitnessStatus = Rx<RxStatus>(RxStatus.empty());

  final Rx<RxStatus> addWitnessStatus = Rx<RxStatus>(RxStatus.empty());
  final Rx<RxStatus> deleteWitnessStatus = Rx<RxStatus>(RxStatus.empty());
  RxBool isZakatPropertyWasiyyah = false.obs;
  Rx<WasyyahContentModel?> contextsData = Rx<WasyyahContentModel?>(null);

  Rx<GetWitnessNomineeResponseModel?> searchedWitnesss = Rx<GetWitnessNomineeResponseModel?>(null);

  RxList<GetWitnessNomineeResponseModel> witnessData = <GetWitnessNomineeResponseModel>[].obs;
  RxList<GetWitnessNomineeResponseModel> witnessesYouData = <GetWitnessNomineeResponseModel>[].obs;
  final TextEditingController searchWitnessController = TextEditingController();
  final RxString searchText = "".obs;

  final TextEditingController relNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();

  final TextEditingController presentAddressController = TextEditingController();

  final TextEditingController permanentAddressController = TextEditingController();

  DateTime? birthDate;

  final GlobalKey<FormState> witnessFormKey = GlobalKey<FormState>();
  @override
  void onInit() async {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    getWitnessData();
    getWitnessesYouData();
  }

  @override
  void dispose() {
    searchWitnessController.clear();
    searchText.value = "";
    tabController.dispose();
    super.dispose();
  }

  ///==================get Witness===========================

  Future<void> getWitnessData() async {
    witnessStatus.value = RxStatus.loading();
    var response = await ApiService.getData(ApiConstants.yourWitness);

    if (response.statusCode == 200 || response.statusCode == 201) {
      witnessData(getWitnessNomineeResponseModelFromJson(jsonEncode(response.body)));

      /// ✅ handle empty vs success
      if (witnessData.isEmpty) {
        witnessStatus.value = RxStatus.empty();
      } else {
        witnessStatus.value = RxStatus.success();
      }
    } else {
      witnessStatus(RxStatus.error(response.body));
    }
  }

  ///==================get witness you===========================

  Future<void> getWitnessesYouData() async {
    witnessesYouStatus(RxStatus.loading());

    var response = await ApiService.getData(ApiConstants.witnessedByAnotherUser);

    if (response.statusCode == 200 || response.statusCode == 201) {
      witnessesYouData(getWitnessNomineeResponseModelFromJson(jsonEncode(response.body)));

      if (witnessesYouData.isEmpty) {
        witnessesYouStatus(RxStatus.empty());
      } else {
        witnessesYouStatus(RxStatus.success());
      }
    } else {
      witnessesYouStatus(RxStatus.error(response.body));
    }
  }

  Future<void> searchWitness() async {
    final email = searchWitnessController.text.trim();
    if (email.isEmpty) return;

    searchWitnessStatus(RxStatus.loading());

    var response = await ApiService.getData(ApiConstants.searchWitness(email));

    if (response.statusCode == 200) {
      final data = response.body;
      searchedWitnesss.value = GetWitnessNomineeResponseModel.fromJson(data);
      if (data.isEmpty) {
        searchWitnessStatus(RxStatus.empty());
      } else {
        searchWitnessStatus(RxStatus.success());
      }
    } else {
      searchWitnessStatus(RxStatus.error(response.body));
      ToastMessage.errorMessageShowToster(response.body);
    }
  }

  ///==================delete witness===========================

  deleteWitness({required String requestKey}) async {
    deleteWitnessStatus(RxStatus.loading());
    var response = await ApiService.getData("${ApiConstants.deleteWitness(requestKey)}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessage.successMessageShowToster(
        AppLocalizations.of(Get.context!)!.witness_remove_successfully,
      );
      getWitnessData();
      deleteWitnessStatus(RxStatus.success());
    } else {
      deleteWitnessStatus(RxStatus.error(response.body));
      ToastMessage.errorMessageShowToster(AppLocalizations.of(Get.context!)!.failed_to_delete_witness);
    }
    try {} catch (e) {}
  }

  ///================== Save witness ===========================
  Future<void> saveWitness({
    required String userName,
    required String mobileNo,
    required String email,
    required String relationWithUser,
    required String dob,
    required String presentAddress,
    required String permanentAddress,
  }) async {
    addWitnessStatus(RxStatus.loading());

    final body = {
      "name": userName.trim(),
      "mobile": mobileNo.trim(),
      "email": email.trim(),
      "relationWithUser": relationWithUser.trim(),
      "dob": dob.trim(),
      "presentAddress": presentAddress.trim(),
      "permanentAddress": permanentAddress.trim(),
    };

    final response = await ApiService.postData(
      ApiConstants.saveWitness,
      body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessage.successMessageShowToster(
        AppLocalizations.of(Get.context!)!.witness_saved_successfully,
      );
    } else {
      ToastMessage.errorMessageShowToster(AppLocalizations.of(Get.context!)!.save_failed_try_again);
    }
  }

  ///================== Add  witness ===========================
  Future<void> addYourWitness({
    required String email,
  }) async {
    addWitnessStatus(RxStatus.loading());

    final response = await ApiService.getData(
      ApiConstants.addYourWitness(email),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessage.successMessageShowToster(
        AppLocalizations.of(Get.context!)!.witness_added_successfully,
      );
      addWitnessStatus(RxStatus.success());
    } else {
      ToastMessage.errorMessageShowToster(/*AppLocalizations.of(Get.context!)!.add_failed_try_again*/ response.body);
      addWitnessStatus(RxStatus.empty());
    }
  }

  ///==================Show Add Witness Bottom Sheet===========================
  void showAddWitnessBottomSheet() {
    searchWitnessController.clear();
    searchText.value = "";
    searchedWitnesss.value = null;
    searchWitnessStatus.value = RxStatus.empty();
    Get.bottomSheet(
      AddWitnesWidget(),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
    );
  }

  ///==================Show Add Outside Witness Bottom Sheet===========================
  void showAddOutsideWitnessBottomSheet() {
    relNameController.clear();
    nameController.clear();
    mobileController.clear();
    emailController.clear();
    dateOfBirthController.clear();
    presentAddressController.clear();
    permanentAddressController.clear();
    birthDate = null;

    Get.bottomSheet(
      AddOutsideWitnessWidget(),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
