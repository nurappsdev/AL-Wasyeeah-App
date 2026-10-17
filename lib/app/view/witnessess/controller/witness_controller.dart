import 'dart:convert';
import 'package:al_wasiyyath/app/core/utils/toast_message.dart';
import 'package:al_wasiyyath/app/view/wasiyyah/model/wasyyah_model.dart';
import 'package:al_wasiyyath/app/view/witnessess/model/get_witness_response_model.dart';
import 'package:al_wasiyyath/app/core/services/api/api_service.dart';
import 'package:al_wasiyyath/app/core/utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_wasiyyath/app/core/l10n/app_localizations.dart';
import 'package:al_wasiyyath/app/view/witnessess/add_outside_witnesses_widget.dart';
import 'package:al_wasiyyath/app/view/witnessess/add_witnesses_widget.dart';

class WitnessController extends GetxController
    with GetSingleTickerProviderStateMixin {
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

  Rx<GetWitnessNomineeResponseModel?> searchedWitnesss =
      Rx<GetWitnessNomineeResponseModel?>(null);

  RxList<GetWitnessNomineeResponseModel> witnessData =
      <GetWitnessNomineeResponseModel>[].obs;
  RxList<GetWitnessNomineeResponseModel> witnessesYouData =
      <GetWitnessNomineeResponseModel>[].obs;
  final TextEditingController searchWitnessController = TextEditingController();
  final RxString searchText = "".obs;

  final TextEditingController relNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();

  final TextEditingController presentAddressController =
      TextEditingController();

  final TextEditingController permanentAddressController =
      TextEditingController();

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
    try {
      final response = await ApiService.getData(ApiConstants.yourWitness);

      if (response.statusCode == 200 || response.statusCode == 201) {
        witnessData(
            getWitnessNomineeResponseModelFromJson(jsonEncode(response.body)));

        /// ✅ handle empty vs success
        if (witnessData.isEmpty) {
          witnessStatus.value = RxStatus.empty();
        } else {
          witnessStatus.value = RxStatus.success();
        }
      } else {
        witnessStatus.value = RxStatus.error(
            response.body?.toString() ?? "Failed to load witness data");
      }
    } catch (e) {
      witnessStatus.value = RxStatus.error(e.toString());
      ToastMessage.errorMessageShowToster(e.toString());
    } finally {
      if (witnessStatus.value.isLoading) {
        witnessStatus.value = RxStatus.empty();
      }
    }
  }

  ///==================get witness you===========================

  Future<void> getWitnessesYouData() async {
    witnessesYouStatus.value = RxStatus.loading();
    try {
      final response =
          await ApiService.getData(ApiConstants.witnessedByAnotherUser);

      if (response.statusCode == 200 || response.statusCode == 201) {
        witnessesYouData(
            getWitnessNomineeResponseModelFromJson(jsonEncode(response.body)));

        if (witnessesYouData.isEmpty) {
          witnessesYouStatus.value = RxStatus.empty();
        } else {
          witnessesYouStatus.value = RxStatus.success();
        }
      } else {
        witnessesYouStatus.value = RxStatus.error(
            response.body?.toString() ?? "Failed to load witnesses you data");
      }
    } catch (e) {
      witnessesYouStatus.value = RxStatus.error(e.toString());
      ToastMessage.errorMessageShowToster(e.toString());
    } finally {
      if (witnessesYouStatus.value.isLoading) {
        witnessesYouStatus.value = RxStatus.empty();
      }
    }
  }

  Future<void> searchWitness() async {
    final email = searchWitnessController.text.trim();
    if (email.isEmpty) return;

    searchWitnessStatus.value = RxStatus.loading();
    try {
      final response =
          await ApiService.getData(ApiConstants.searchWitness(email));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.body;
        if (data == null || (data is Map && data.isEmpty)) {
          searchedWitnesss.value = null;
          searchWitnessStatus.value = RxStatus.empty();
        } else {
          searchedWitnesss.value =
              GetWitnessNomineeResponseModel.fromJson(data);
          searchWitnessStatus.value = RxStatus.success();
        }
      } else {
        searchWitnessStatus.value = RxStatus.error(
            response.body?.toString() ?? "Failed to search witness");
        ToastMessage.errorMessageShowToster(
            response.body?.toString() ?? "Failed to search witness");
      }
    } catch (e) {
      searchWitnessStatus.value = RxStatus.error(e.toString());
      ToastMessage.errorMessageShowToster(e.toString());
    } finally {
      if (searchWitnessStatus.value.isLoading) {
        searchWitnessStatus.value = RxStatus.empty();
      }
    }
  }

  ///==================delete witness===========================

  Future<bool> deleteWitness({required String requestKey}) async {
    deleteWitnessStatus.value = RxStatus.loading();
    try {
      final response =
          await ApiService.getData(ApiConstants.deleteWitness(requestKey));
      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessage.successMessageShowToster(
          AppLocalizations.of(Get.context!)?.witness_remove_successfully ??
              "Witness removed successfully",
        );
        deleteWitnessStatus.value = RxStatus.success();
        await getWitnessData();
        return true;
      } else {
        deleteWitnessStatus.value = RxStatus.error(
            response.body?.toString() ?? "Failed to delete witness");
        ToastMessage.errorMessageShowToster(
          AppLocalizations.of(Get.context!)?.failed_to_delete_witness ??
              "Failed to delete witness",
        );
        return false;
      }
    } catch (e) {
      deleteWitnessStatus.value = RxStatus.error(e.toString());
      ToastMessage.errorMessageShowToster(e.toString());
      return false;
    } finally {
      if (deleteWitnessStatus.value.isLoading) {
        deleteWitnessStatus.value = RxStatus.empty();
      }
    }
  }

  ///================== Save witness ===========================
  Future<bool> saveWitness({
    required String userName,
    required String mobileNo,
    required String email,
    required String relationWithUser,
    required String dob,
    required String presentAddress,
    required String permanentAddress,
  }) async {
    addWitnessStatus.value = RxStatus.loading();

    final body = {
      "name": userName.trim(),
      "mobile": mobileNo.trim(),
      "email": email.trim(),
      "relationWithUser": relationWithUser.trim(),
      "dob": dob.trim(),
      "presentAddress": presentAddress.trim(),
      "permanentAddress": permanentAddress.trim(),
    };

    try {
      final response = await ApiService.postData(
        ApiConstants.saveWitness,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessage.successMessageShowToster(
          AppLocalizations.of(Get.context!)?.witness_saved_successfully ??
              "Witness saved successfully",
        );
        addWitnessStatus.value = RxStatus.success();
        await getWitnessData();
        Get.back();
        return true;
      } else {
        addWitnessStatus.value = RxStatus.error(
            response.body?.toString() ?? "Failed to save witness");
        ToastMessage.errorMessageShowToster(
          AppLocalizations.of(Get.context!)?.save_failed_try_again ??
              "Save failed, try again",
        );
        return false;
      }
    } catch (e) {
      addWitnessStatus.value = RxStatus.error(e.toString());
      ToastMessage.errorMessageShowToster(e.toString());
      return false;
    } finally {
      if (addWitnessStatus.value.isLoading) {
        addWitnessStatus.value = RxStatus.empty();
      }
    }
  }

  ///================== Add  witness ===========================
  Future<bool> addYourWitness({
    required String email,
  }) async {
    addWitnessStatus.value = RxStatus.loading();

    try {
      final response = await ApiService.getData(
        ApiConstants.addYourWitness(email),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessage.successMessageShowToster(
          AppLocalizations.of(Get.context!)?.witness_added_successfully ??
              "Witness added successfully",
        );
        addWitnessStatus.value = RxStatus.success();
        await getWitnessData();
        return true;
      } else {
        addWitnessStatus.value = RxStatus.error(
            response.body?.toString() ?? "Failed to add witness");
        ToastMessage.errorMessageShowToster(
          response.body?.toString() ??
              AppLocalizations.of(Get.context!)?.add_failed_try_again ??
              "Failed to add witness",
        );
        return false;
      }
    } catch (e) {
      addWitnessStatus.value = RxStatus.error(e.toString());
      ToastMessage.errorMessageShowToster(e.toString());
      return false;
    } finally {
      if (addWitnessStatus.value.isLoading) {
        addWitnessStatus.value = RxStatus.empty();
      }
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
