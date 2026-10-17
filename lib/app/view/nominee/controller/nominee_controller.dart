import 'dart:convert';
import 'package:al_wasiyyath/app/core/utils/toast_message.dart';
import 'package:al_wasiyyath/app/view/witnessess/model/get_witness_response_model.dart';
import 'package:al_wasiyyath/app/core/services/api/api_service.dart';
import 'package:al_wasiyyath/app/core/utils/api_constants.dart';
import 'package:al_wasiyyath/app/view/nominee/add_nominee_widget.dart';
import 'package:al_wasiyyath/app/view/nominee/add_outside_nominee_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_wasiyyath/app/core/l10n/app_localizations.dart';

class NomineeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  /// For "Your Witness"
  final Rx<RxStatus> nomineeStatus = Rx<RxStatus>(RxStatus.loading());

  /// For "I'm Witness"
  final Rx<RxStatus> nomineesYouStatus = Rx<RxStatus>(RxStatus.loading());

  final Rx<RxStatus> searchNomineeStatus = Rx<RxStatus>(RxStatus.empty());

  final Rx<RxStatus> addNomineeStatus = Rx<RxStatus>(RxStatus.empty());
  final Rx<RxStatus> deleteNomineeStatus = Rx<RxStatus>(RxStatus.empty());

  Rx<GetWitnessNomineeResponseModel?> searchedNominee =
      Rx<GetWitnessNomineeResponseModel?>(null);

  RxList<GetWitnessNomineeResponseModel> nomineeData =
      <GetWitnessNomineeResponseModel>[].obs;
  RxList<GetWitnessNomineeResponseModel> nomineesYouData =
      <GetWitnessNomineeResponseModel>[].obs;
  final TextEditingController searchNomineeController = TextEditingController();
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

  final GlobalKey<FormState> nomineeFormKey = GlobalKey<FormState>();
  @override
  void onInit() async {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    getNomineeData();
    getNomineesYouData();
  }

  @override
  void dispose() {
    searchNomineeController.clear();
    searchText.value = "";
    tabController.dispose();
    super.dispose();
  }

  ///==================get Nominee===========================

  Future<void> getNomineeData() async {
    nomineeStatus.value = RxStatus.loading();
    try {
      final response = await ApiService.getData(ApiConstants.yourNominee);

      if (response.statusCode == 200 || response.statusCode == 201) {
        nomineeData(
            getWitnessNomineeResponseModelFromJson(jsonEncode(response.body)));

        /// ✅ handle empty vs success
        if (nomineeData.isEmpty) {
          nomineeStatus.value = RxStatus.empty();
        } else {
          nomineeStatus.value = RxStatus.success();
        }
      } else {
        nomineeStatus.value = RxStatus.error(
            response.body?.toString() ?? "Failed to load nominee data");
      }
    } catch (e) {
      nomineeStatus.value = RxStatus.error(e.toString());
      ToastMessage.errorMessageShowToster(e.toString());
    } finally {
      if (nomineeStatus.value.isLoading) {
        nomineeStatus.value = RxStatus.empty();
      }
    }
  }

  ///==================get nominee you===========================

  Future<void> getNomineesYouData() async {
    nomineesYouStatus.value = RxStatus.loading();
    try {
      final response =
          await ApiService.getData(ApiConstants.nomineedByAnotherUser);

      if (response.statusCode == 200 || response.statusCode == 201) {
        nomineesYouData(
            getWitnessNomineeResponseModelFromJson(jsonEncode(response.body)));

        if (nomineesYouData.isEmpty) {
          nomineesYouStatus.value = RxStatus.empty();
        } else {
          nomineesYouStatus.value = RxStatus.success();
        }
      } else {
        nomineesYouStatus.value = RxStatus.error(
            response.body?.toString() ?? "Failed to load nominees you data");
      }
    } catch (e) {
      nomineesYouStatus.value = RxStatus.error(e.toString());
      ToastMessage.errorMessageShowToster(e.toString());
    } finally {
      if (nomineesYouStatus.value.isLoading) {
        nomineesYouStatus.value = RxStatus.empty();
      }
    }
  }

  Future<void> searchNominee() async {
    final email = searchNomineeController.text.trim();
    if (email.isEmpty) return;

    searchNomineeStatus.value = RxStatus.loading();
    try {
      final response =
          await ApiService.getData(ApiConstants.searchNominee(email));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.body;
        if (data == null || (data is Map && data.isEmpty)) {
          searchedNominee.value = null;
          searchNomineeStatus.value = RxStatus.empty();
        } else {
          searchedNominee.value = GetWitnessNomineeResponseModel.fromJson(data);
          searchNomineeStatus.value = RxStatus.success();
        }
      } else {
        searchNomineeStatus.value = RxStatus.error(
            response.body?.toString() ?? "Failed to search nominee");
        ToastMessage.errorMessageShowToster(
            response.body?.toString() ?? "Failed to search nominee");
      }
    } catch (e) {
      searchNomineeStatus.value = RxStatus.error(e.toString());
      ToastMessage.errorMessageShowToster(e.toString());
    } finally {
      if (searchNomineeStatus.value.isLoading) {
        searchNomineeStatus.value = RxStatus.empty();
      }
    }
  }

  ///==================delete nominee===========================

  Future<bool> deleteNominee({required String requestKey}) async {
    deleteNomineeStatus.value = RxStatus.loading();
    try {
      final response =
          await ApiService.getData(ApiConstants.deleteNominee(requestKey));
      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessage.successMessageShowToster(
          AppLocalizations.of(Get.context!)?.nominee_remove_successfully ??
              "Nominee removed successfully",
        );
        deleteNomineeStatus.value = RxStatus.success();
        await getNomineeData();
        return true;
      } else {
        deleteNomineeStatus.value = RxStatus.error(
            response.body?.toString() ?? "Failed to delete nominee");
        ToastMessage.errorMessageShowToster(
          AppLocalizations.of(Get.context!)?.failed_to_delete_nominee ??
              "Failed to delete nominee",
        );
        return false;
      }
    } catch (e) {
      deleteNomineeStatus.value = RxStatus.error(e.toString());
      ToastMessage.errorMessageShowToster(e.toString());
      return false;
    } finally {
      if (deleteNomineeStatus.value.isLoading) {
        deleteNomineeStatus.value = RxStatus.empty();
      }
    }
  }

  ///================== Save nominee ===========================
  Future<bool> saveNominee({
    required String userName,
    required String mobileNo,
    required String email,
    required String relationWithUser,
    required String dob,
    required String presentAddress,
    required String permanentAddress,
  }) async {
    addNomineeStatus.value = RxStatus.loading();

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
        ApiConstants.saveNominee,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessage.successMessageShowToster(
          AppLocalizations.of(Get.context!)?.nominee_saved_successfully ??
              "Nominee saved successfully",
        );
        addNomineeStatus.value = RxStatus.success();
        await getNomineeData();
        Get.back();
        return true;
      } else {
        addNomineeStatus.value = RxStatus.error(
            response.body?.toString() ?? "Failed to save nominee");
        ToastMessage.errorMessageShowToster(
          AppLocalizations.of(Get.context!)?.save_failed_try_again ??
              "Save failed, try again",
        );
        return false;
      }
    } catch (e) {
      addNomineeStatus.value = RxStatus.error(e.toString());
      ToastMessage.errorMessageShowToster(e.toString());
      return false;
    } finally {
      if (addNomineeStatus.value.isLoading) {
        addNomineeStatus.value = RxStatus.empty();
      }
    }
  }

  ///================== Add nominee ===========================
  Future<bool> addYourNominee({
    required String email,
  }) async {
    addNomineeStatus.value = RxStatus.loading();

    try {
      final response = await ApiService.getData(
        ApiConstants.addYourNominee(email),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessage.successMessageShowToster(
          AppLocalizations.of(Get.context!)?.nominee_added_successfully ??
              "Nominee added successfully",
        );
        addNomineeStatus.value = RxStatus.success();
        await getNomineeData();
        return true;
      } else {
        addNomineeStatus.value = RxStatus.error(
            response.body?.toString() ?? "Failed to add nominee");
        ToastMessage.errorMessageShowToster(
          response.body?.toString() ??
              AppLocalizations.of(Get.context!)?.add_failed_try_again ??
              "Failed to add nominee",
        );
        return false;
      }
    } catch (e) {
      addNomineeStatus.value = RxStatus.error(e.toString());
      ToastMessage.errorMessageShowToster(e.toString());
      return false;
    } finally {
      if (addNomineeStatus.value.isLoading) {
        addNomineeStatus.value = RxStatus.empty();
      }
    }
  }

  ///==================Show Add Witness Bottom Sheet===========================
  void showAddNomineeBottomSheet() {
    searchNomineeController.clear();
    searchText.value = "";
    searchedNominee.value = null;
    searchNomineeStatus.value = RxStatus.empty();
    Get.bottomSheet(
      AddNomineeWidget(),
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
  void showAddOutsideNomineeBottomSheet() {
    relNameController.clear();
    nameController.clear();
    mobileController.clear();
    emailController.clear();
    dateOfBirthController.clear();
    presentAddressController.clear();
    permanentAddressController.clear();
    birthDate = null;

    Get.bottomSheet(
      AddOutsideNomineeWidget(),
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
