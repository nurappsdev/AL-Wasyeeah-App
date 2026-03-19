import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/prefs_helper.dart';
import '../../helpers/toast_message_helper.dart';
import '../../models/access_phanel/zakat_property_wasyyah_model.dart';
import '../../models/models.dart';
import '../../models/nominee/search_asign_nominee_model.dart';
import '../../services/services.dart';
import 'package:http/http.dart' as http;

import 'package:al_wasyeah/l10n/app_localizations.dart';
import 'package:al_wasyeah/view/witnessess/add_outside_witness.dart';
import 'package:al_wasyeah/view/witnessess/add_witness_screen.dart';
import '../../utils/app_constant.dart';

class WitnessController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  /// For "Your Witness"
  final Rx<RxStatus> witnessStatus = Rx<RxStatus>(RxStatus.loading());

  /// For "I'm Witness"
  final Rx<RxStatus> witnessesYouStatus = Rx<RxStatus>(RxStatus.loading());

  @override
  void onInit() async {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    getWitnessData();
    getWitnessesYouData();
  }

  @override
  void dispose() {
    searchController.clear();
    tabController.dispose();
    super.dispose();
  }

  ///==================get Witness===========================
  RxList<GetWitnessResponseModel> witnessData = <GetWitnessResponseModel>[].obs;

  Future<void> getWitnessData() async {
    witnessStatus.value = RxStatus.loading();

    try {
      var response = await ApiClient.getData(ApiConstants.witnessEndPoint);

      if (response.statusCode == 200 || response.statusCode == 201) {
        witnessData(getWitnessResponseModelFromJson(jsonEncode(response.body)));

        /// ✅ handle empty vs success
        if (witnessData.isEmpty) {
          witnessStatus.value = RxStatus.empty();
        } else {
          witnessStatus.value = RxStatus.success();
        }
      } else {
        witnessStatus.value = RxStatus.error("Failed to load data");
      }
    } catch (e) {
      witnessStatus.value = RxStatus.error(e.toString());
    }
  }

  ///==================get nominee===========================
  RxList<GetWitnessResponseModel> witnessesYouData =
      <GetWitnessResponseModel>[].obs;

  Future<void> getWitnessesYouData() async {
    witnessesYouStatus(RxStatus.loading());

    try {
      var response = await ApiClient.getData(ApiConstants.witnessesYouEndPoint);

      if (response.statusCode == 200 || response.statusCode == 201) {
        witnessesYouData(
            getWitnessResponseModelFromJson(jsonEncode(response.body)));

        /// ✅ handle empty vs success
        if (witnessesYouData.isEmpty) {
          witnessesYouStatus(RxStatus.empty());
        } else {
          witnessesYouStatus(RxStatus.success());
        }
      } else {
        witnessesYouStatus(RxStatus.error("Failed to load data"));
      }
    } catch (e) {
      witnessesYouStatus(RxStatus.error(e.toString()));
    }
  }

  final TextEditingController searchController = TextEditingController();
  // var isLoading = false.obs;
  // var witnesssData = {}.obs;
  //
  // Future<void> searchWitness() async {
  //   final email = searchController.text.trim();
  //   if (email.isEmpty) return;
  //
  //   isLoading.value = true;
  //
  //   final url = Uri.parse(
  //     '${ApiConstants.baseUrl}/user/search-witness-nominee?email=$email&isWitness=true',
  //   );
  //   String token = await PrefsHelper.getString(AppConstants.bearerToken);
  //   try {
  //     final response = await http.get(
  //         url,
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //     );
  //     print("response.body---------------${response.body}");
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       witnesssData.value = data;
  //     } else {
  //       Get.snackbar("Error", "This is not right email");
  //       witnesssData.value = {};
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Something went wrong");
  //     witnesssData.value = {};
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  //

  var isLoading = false.obs;

  Rx<SearchAsignResponseModel?> witnesssData =
      Rx<SearchAsignResponseModel?>(null);

  Future<void> searchWitness() async {
    final email = searchController.text.trim();
    if (email.isEmpty) return;

    isLoading.value = true;

    final url = Uri.parse(
      '${ApiConstants.baseUrl}/user/search-witness-nominee?email=$email&isWitness=true',
    );

    String token = await PrefsHelper.getString(AppConstants.bearerToken);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("response.body---------------${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        witnesssData.value = SearchAsignResponseModel.fromJson(data);
      } else {
        Get.snackbar(AppLocalizations.of(Get.context!)!.error,
            AppLocalizations.of(Get.context!)!.invalid_email_message);
        witnesssData.value = null;
      }
    } catch (e) {
      Get.snackbar(AppLocalizations.of(Get.context!)!.error,
          AppLocalizations.of(Get.context!)!.something_went_wrong);
      witnesssData.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  ///==================get Question===========================
  final Rx<RxStatus> deleteWitnessStatus = Rx<RxStatus>(RxStatus.empty());
  deleteWitness({required String requestKey}) async {
    deleteWitnessStatus(RxStatus.loading());
    var response = await ApiClient.getData(
        "${ApiConstants.witnessDeletePoint(requestKey)}");
    log("deleteData data ------------${response.body}");
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessageHelper.successMessageShowToster(
          AppLocalizations.of(Get.context!)!.witness_remove_successfully,
        );
        getWitnessData();
        deleteWitnessStatus(RxStatus.success());
      }
    } catch (e) {
      deleteWitnessStatus(RxStatus.error(e.toString()));
      ToastMessageHelper.errorMessageShowToster(
          AppLocalizations.of(Get.context!)!.try_again);
    }
  }

  RxBool isZakatPropertyWasiyyah = false.obs;
  Rx<ZakatPropertyWasiyyahModel?> contextsData =
      Rx<ZakatPropertyWasiyyahModel?>(null);

  /// 🔥 DIRECT API CALL INSIDE CONTROLLER
  Future<void> fetchContextsData(String requestKey) async {
    try {
      isZakatPropertyWasiyyah.value = true;

      var response = await ApiClient.getData(
        "${ApiConstants.baseUrl}/getContextsData?requestKey=$requestKey",
      );
      print("deleteData data ------------${response.body}");

      if (response.statusCode != 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        contextsData.value = ZakatPropertyWasiyyahModel.fromJson(data);
      } else {
        throw Exception(
            "${AppLocalizations.of(Get.context!)!.request_failed_with_status}: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar(AppLocalizations.of(Get.context!)!.error, e.toString());
    } finally {
      isZakatPropertyWasiyyah.value = false;
    }
  }

  final isLoadings = false.obs;
  final hasContextsData = false.obs;

  final zakat = <String, dynamic>{}.obs;
  final propertyResult = <dynamic>[].obs;
  final wasiyyahContent = <dynamic>[].obs;

  Future<void> getContextsData(String requestKey) async {
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    try {
      isLoadings.value = true;
      hasContextsData.value = false;

      final uri = Uri.parse(
        '${ApiConstants.baseUrl}/getContextsData?requestKey=$requestKey',
      );

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
      );

      if (response.statusCode == 200) {
        // ✅ UTF-8 decode (Bangla safe)
        final decodedBody = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> data = jsonDecode(decodedBody);

        /// 🔴 যদি API empty object দেয়
        if (data.isEmpty) {
          hasContextsData.value = false;
          return;
        }

        // zakat
        zakat.value = data['zakat'] ?? {};

        // propertyResult (string JSON হলে)
        propertyResult.value = data['propertyResult'] != null
            ? jsonDecode(data['propertyResult'])
            : [];

        // wasiyyahContent
        wasiyyahContent.value = data['wasiyyahContent'] ?? [];

        /// ✅ data valid
        hasContextsData.value = true;
      } else {
        /// ❌ requestKey match না করলে
        hasContextsData.value = false;
      }
    } catch (e) {
      hasContextsData.value = false;
    } finally {
      isLoadings.value = false;
    }
  }

  ///==================Show Add Witness Bottom Sheet===========================
  void showAddWitnessBottomSheet() {
    searchController.clear();
    witnesssData.value = null;
    Get.bottomSheet(
      AddWitnessScreen(),
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
      AddOutsideWitness(),
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
