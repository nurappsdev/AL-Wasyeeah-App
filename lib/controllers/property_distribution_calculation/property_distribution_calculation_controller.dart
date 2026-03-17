import 'dart:convert';
import 'dart:developer';
import 'package:al_wasyeah/l10n/app_localizations.dart';
import 'package:al_wasyeah/models/property_distribution_calculation_model/property_destribution_result_model.dart';
import 'package:flutter/material.dart';
import 'package:al_wasyeah/helpers/toast_message_helper.dart';
import 'package:al_wasyeah/services/api_client.dart';
import 'package:al_wasyeah/services/api_constants.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/models/property_distribution_calculation_model/relavant_list_model.dart';
import 'package:intl/intl.dart';

class PropertyDistributionCalculationController extends GetxController {
  final Rx<RxStatus> status = RxStatus.loading().obs;

  RxList<RelativeModelForPropertyDistribution> allRelatives =
      <RelativeModelForPropertyDistribution>[].obs;
  RxList<PropertydistributionResultModel> propertyDistributionResult =
      <PropertydistributionResultModel>[].obs;

  // Constants for Encrypted Relative IDs
  static const String husbandId = "j1mjV6qs9iab4mbEVNyg0A==";
  static const String wifeId = "L3KSP53cxd1tnhTXblgTZw==";
  static const String fatherId = "ES+jQvYP4Jfl7olyUlJ9RQ==";
  static const String motherId = "P1EMaXcfDjHvaG3FENSJ0g==";
  static const String grandfatherId = "zkX+xHUpZv1cdAjWQHiLxg==";
  static const String deceasedSonId = "aTZX79XB0XkeLgERIo2OIw==";
  static const String deceasedDaughterId = "20wmeXeB57v9gv5lN+jWrA==";
  static const String sonId = "SMYEnVLnIn1kIwp8wuJnQQ==";
  static const String daughterId = "Eb4fRY9JhIcz7l+KvhqwlA==";
  static const String deceasedSonsSonId = "HpOMjLTogw9LacBtPZnBYw==";
  static const String deceasedSonsDaughterId = "UX3C0ze3peC15PxKMKcLKw==";
  static const String deceasedDaughtersSonId = "rKt0JEpkWRnmry8/vxHLHg==";
  static const String deceasedDaughtersDaughterId = "oWmEwQJfpNvTtt5jYXWsoA==";

  // Selection and Counts - Now using Encrypted ID as key
  RxMap<String, bool> isChecked = <String, bool>{}.obs;
  RxMap<String, int> counts = <String, int>{}.obs;

  // For dynamic items (Deceased Son/Daughter sub-items)
  // Key format: "Deceased 1st Son's Son" -> count
  RxMap<String, bool> dynamicIsChecked = <String, bool>{}.obs;
  RxMap<String, int> dynamicCounts = <String, int>{}.obs;

  // Property Calculation Fields
  final landController = TextEditingController();
  final goldController = TextEditingController();
  final silverController = TextEditingController();
  final moneyController = TextEditingController();

  RxString goldUnit = "gram".obs;
  RxString silverUnit = "gram".obs;

  RxBool isCalculateVisible = false.obs;
  RxBool isCalculateLoading = false.obs;

  final List<String> hiddenRelativeIds = [
    deceasedSonsSonId,
    deceasedSonsDaughterId,
    deceasedDaughtersSonId,
    deceasedDaughtersDaughterId,
  ];

  @override
  void onInit() {
    super.onInit();
    initData();

    // Add listeners to property fields to toggle button visibility
    landController.addListener(_checkVisibility);
    goldController.addListener(_checkVisibility);
    silverController.addListener(_checkVisibility);
    moneyController.addListener(_checkVisibility);
  }

  void _checkVisibility() {
    isCalculateVisible.value = landController.text.isNotEmpty ||
        goldController.text.isNotEmpty ||
        silverController.text.isNotEmpty ||
        moneyController.text.isNotEmpty;
  }

  @override
  void onClose() {
    landController.dispose();
    goldController.dispose();
    silverController.dispose();
    moneyController.dispose();
    super.onClose();
  }

  Future<void> initData() async {
    status.value = RxStatus.loading();
    await getRelevantList();
    await loadRelatives();
    status.value = RxStatus.success();
  }

  Future<void> getRelevantList() async {
    try {
      var response = await ApiClient.getData(
        ApiConstants.relevantList,
      );
      allRelatives(relevantListFromJson(jsonEncode(response.body)));
    } catch (e, s) {
      log("Marital List Error: $e\nStacktrace: $s");
    }
  }

  Future<void> loadRelatives() async {
    for (var rel in allRelatives) {
      if (rel.encrypted != null) {
        isChecked[rel.encrypted!] = false;
        counts[rel.encrypted!] = 0;
      }
    }
  }

  List<RelativeModelForPropertyDistribution> get filteredRelatives {
    return allRelatives
        .where((rel) => !hiddenRelativeIds.contains(rel.encrypted))
        .toList();
  }

  void toggleCheck(String encryptedId, bool? value) {
    if (value == true) {
      if (encryptedId == husbandId && isChecked[wifeId] == true) {
        ToastMessageHelper.errorMessageShowToster(
            AppLocalizations.of(Get.context!)!
                .husband_and_wife_cant_be_selected_together);
        isChecked[wifeId] = false;
        counts[wifeId] = 0;
      } else if (encryptedId == wifeId && isChecked[husbandId] == true) {
        ToastMessageHelper.errorMessageShowToster(
            AppLocalizations.of(Get.context!)!
                .husband_and_wife_cant_be_selected_together);
        isChecked[husbandId] = false;
        counts[husbandId] = 0;
      }
      isChecked[encryptedId] = true;
      if ((counts[encryptedId] ?? 0) == 0) counts[encryptedId] = 1;

      // Handle special limit for Husband, Father, Mother, Grandfather
      if ((encryptedId == husbandId ||
              encryptedId == fatherId ||
              encryptedId == motherId ||
              encryptedId == grandfatherId) &&
          (counts[encryptedId] ?? 0) > 1) {
        counts[encryptedId] = 1;
      }
    } else {
      isChecked[encryptedId] = false;
      counts[encryptedId] = 0;
    }
    update();
  }

  void increment(String encryptedId) {
    if (isChecked[encryptedId] != true) return;

    if (encryptedId == husbandId ||
        encryptedId == fatherId ||
        encryptedId == motherId ||
        encryptedId == grandfatherId) {
      if ((counts[encryptedId] ?? 0) >= 1) return;
    }

    counts[encryptedId] = (counts[encryptedId] ?? 0) + 1;
    update();
  }

  void decrement(String encryptedId) {
    if (isChecked[encryptedId] != true) return;
    if ((counts[encryptedId] ?? 0) > 0) {
      counts[encryptedId] = (counts[encryptedId] ?? 0) - 1;
      if (counts[encryptedId] == 0) {
        isChecked[encryptedId] = false;
      }
    }
    update();
  }

  // Dynamic Item methods
  void toggleDynamicCheck(String key, bool? value) {
    dynamicIsChecked[key] = value ?? false;
    if (dynamicIsChecked[key] == true && (dynamicCounts[key] ?? 0) == 0) {
      dynamicCounts[key] = 1;
    } else if (dynamicIsChecked[key] == false) {
      dynamicCounts[key] = 0;
    }
    update();
  }

  void incrementDynamic(String key) {
    if (dynamicIsChecked[key] != true) return;
    dynamicCounts[key] = (dynamicCounts[key] ?? 0) + 1;
    update();
  }

  void decrementDynamic(String key) {
    if (dynamicIsChecked[key] != true) return;
    if ((dynamicCounts[key] ?? 0) > 0) {
      dynamicCounts[key] = (dynamicCounts[key] ?? 0) - 1;
      if (dynamicCounts[key] == 0) {
        dynamicIsChecked[key] = false;
      }
    }
    update();
  }

  void submitCalculation() async {
    Map<String, int> relatives = {};

    // 1. Map standard relatives
    isChecked.forEach((encryptedId, isSel) {
      if (isSel) {
        String key = "relative_no_$encryptedId";
        relatives[key] = counts[encryptedId] ?? 0;
      }
    });

    // 2. Map dynamic (deceased) relatives
    // UI Key example: "Deceased 1st Son's Son"
    dynamicIsChecked.forEach((uiKey, isSel) {
      if (isSel) {
        String mappedKey = _mapDynamicKeyToShortKey(uiKey);
        relatives[mappedKey] = dynamicCounts[uiKey] ?? 0;
      }
    });

    Map<String, dynamic> finalOutput = {
      "relative": [relatives],
    };

    // 3. Add Property fields
    if (landController.text.isNotEmpty) {
      finalOutput["propertyLand"] = double.tryParse(landController.text) ?? 0;
    }
    if (goldController.text.isNotEmpty) {
      double goldVal = double.tryParse(goldController.text) ?? 0;
      if (goldUnit.value == "vori") {
        goldVal = goldVal * 11.664;
      }
      finalOutput["propertyGold"] = goldVal;
    }
    if (silverController.text.isNotEmpty) {
      double silverVal = double.tryParse(silverController.text) ?? 0;
      if (silverUnit.value == "vori") {
        silverVal = silverVal * 11.664;
      }
      finalOutput["propertySilver"] = silverVal;
    }
    if (moneyController.text.isNotEmpty) {
      finalOutput["propertyTk"] = double.tryParse(moneyController.text) ?? 0;
    }

    log("Final Submission JSON: ${jsonEncode(finalOutput)}");

    try {
      isCalculateLoading.value = true;
      var response = await ApiClient.postData(
          ApiConstants.propertyDistributionCalculationResult, finalOutput);
      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessageHelper.successMessageShowToster(
            AppLocalizations.of(Get.context!)!
                .calculation_fetched_successfully);
        propertyDistributionResult.value =
            propertydistributionResultModelFromJson(jsonEncode(response.body));

        // Reset all inputs after success if needed
        resetInputs();
      } else {
        ToastMessageHelper.errorMessageShowToster(
            AppLocalizations.of(Get.context!)!
                .failed_to_fetch_calculation_result);
      }
    } catch (e, s) {
      log("Property Calculation Error: $e\nStacktrace: $s");
      ToastMessageHelper.errorMessageShowToster(
          AppLocalizations.of(Get.context!)!.something_went_wrong);
    } finally {
      isCalculateLoading.value = false;
    }
  }

  void resetInputs() {
    isChecked.clear();
    counts.clear();
    dynamicIsChecked.clear();
    dynamicCounts.clear();
    landController.clear();
    goldController.clear();
    silverController.clear();
    moneyController.clear();
    goldUnit.value = "gram";
    silverUnit.value = "gram";
    isCalculateVisible.value = false;
    update();
  }

  String _mapDynamicKeyToShortKey(String uiKey) {
    // Stable Key format: "deceased_parentEnc_childEnc_index"
    // Example: "deceased_aTZX79XB0XkeLgERIo2OIw==_SMYEnVLnIn1kIwp8wuJnQQ==_1"

    final parts = uiKey.split('_');
    if (parts.length == 4 && parts[0] == 'deceased') {
      String parentEnc = parts[1];
      String childEnc = parts[2];
      int index = int.tryParse(parts[3]) ?? 1;
      return "relative_no_${parentEnc}_${childEnc}_$index";
    }

    return uiKey; // Fallback
  }

  String getOrdinal(
    int n,
  ) {
    if (Get.locale!.languageCode == 'bn') {
      // Bangla Ordinal Logic
      final String bengaliNumber =
          NumberFormat.decimalPattern(Get.locale!.languageCode).format(n);

      // Bangla ordinals often use specific words or suffixes (১ম, ২য়, ৩য়, ৪র্থ...)
      const suffixes = {1: 'ম', 2: 'য়', 3: 'য়', 4: 'র্থ'};
      return "$bengaliNumber${suffixes[n] ?? 'তম'}";
    } else {
      // English Ordinal Logic (Handling 11th, 12th, 13th exceptions)
      if (n >= 11 && n <= 13) {
        return "${n}th";
      }

      switch (n % 10) {
        case 1:
          return "${n}st";
        case 2:
          return "${n}nd";
        case 3:
          return "${n}rd";
        default:
          return "${n}th";
      }
    }
  }
}
