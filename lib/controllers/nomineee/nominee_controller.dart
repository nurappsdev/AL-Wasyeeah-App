import 'dart:convert';
import 'package:al_wasyeah/view/nominee/add_nominee_widget.dart';
import 'package:al_wasyeah/view/nominee/add_outside_nominee_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helpers/toast_message_helper.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';

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
    tabController.dispose();
    super.dispose();
  }

  ///==================get Witness===========================

  Future<void> getNomineeData() async {
    nomineeStatus.value = RxStatus.loading();
    var response = await ApiClient.getData(ApiConstants.yourNominee);

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
      nomineeStatus(RxStatus.error(response.body));
    }
  }

  ///==================get witness you===========================

  Future<void> getNomineesYouData() async {
    nomineesYouStatus(RxStatus.loading());

    var response = await ApiClient.getData(ApiConstants.nomineedByAnotherUser);

    if (response.statusCode == 200 || response.statusCode == 201) {
      nomineesYouData(
          getWitnessNomineeResponseModelFromJson(jsonEncode(response.body)));

      if (nomineesYouData.isEmpty) {
        nomineesYouStatus(RxStatus.empty());
      } else {
        nomineesYouStatus(RxStatus.success());
      }
    } else {
      nomineesYouStatus(RxStatus.error(response.body));
    }
  }

  Future<void> searchNominee() async {
    final email = searchNomineeController.text.trim();
    if (email.isEmpty) return;

    searchNomineeStatus(RxStatus.loading());

    var response = await ApiClient.getData(ApiConstants.searchNominee(email));

    if (response.statusCode == 200) {
      final data = response.body;
      searchedNominee.value = GetWitnessNomineeResponseModel.fromJson(data);
      if (data.isEmpty) {
        searchNomineeStatus(RxStatus.empty());
      } else {
        searchNomineeStatus(RxStatus.success());
      }
    } else {
      searchNomineeStatus(RxStatus.error(response.body));
      ToastMessageHelper.errorMessageShowToster(response.body);
    }
  }

  ///==================delete witness===========================

  deleteNominee({required String requestKey}) async {
    deleteNomineeStatus(RxStatus.loading());
    var response =
        await ApiClient.getData("${ApiConstants.deleteNominee(requestKey)}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.successMessageShowToster(
        AppLocalizations.of(Get.context!)!.nominee_remove_successfully,
      );
      getNomineeData();
      deleteNomineeStatus(RxStatus.success());
    } else {
      deleteNomineeStatus(RxStatus.error(response.body));
      ToastMessageHelper.errorMessageShowToster(
          AppLocalizations.of(Get.context!)!.failed_to_delete_nominee);
    }
    try {} catch (e) {}
  }

  ///================== Save nominee ===========================
  Future<void> saveNominee({
    required String userName,
    required String mobileNo,
    required String email,
    required String relationWithUser,
    required String dob,
    required String presentAddress,
    required String permanentAddress,
  }) async {
    addNomineeStatus(RxStatus.loading());

    final body = {
      "name": userName.trim(),
      "mobile": mobileNo.trim(),
      "email": email.trim(),
      "relationWithUser": relationWithUser.trim(),
      "dob": dob.trim(),
      "presentAddress": presentAddress.trim(),
      "permanentAddress": permanentAddress.trim(),
    };

    final response = await ApiClient.postData(
      ApiConstants.saveNominee,
      body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.successMessageShowToster(
        AppLocalizations.of(Get.context!)!.nominee_saved_successfully,
      );
    } else {
      ToastMessageHelper.errorMessageShowToster(
          AppLocalizations.of(Get.context!)!.save_failed_try_again);
    }
  }

  ///================== Add  witness ===========================
  Future<void> addNominee({
    required String email,
  }) async {
    addNomineeStatus(RxStatus.loading());

    final response = await ApiClient.getData(
      ApiConstants.addYourNominee(email),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.successMessageShowToster(
        AppLocalizations.of(Get.context!)!.nominee_added_successfully,
      );
    } else {
      ToastMessageHelper.errorMessageShowToster(
          AppLocalizations.of(Get.context!)!.add_failed_try_again);
    }
  }

  ///==================Show Add Witness Bottom Sheet===========================
  void showAddNomineeBottomSheet() {
    searchNomineeController.clear();
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
  void showAddOutsideWitnessBottomSheet() {
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
