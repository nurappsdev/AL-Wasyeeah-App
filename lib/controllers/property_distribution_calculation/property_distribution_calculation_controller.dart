import 'dart:convert';
import 'dart:developer';
import 'package:al_wasyeah/models/property_distribution_calculation_model/property_destribution_result_model.dart';
import 'package:flutter/material.dart';
import 'package:al_wasyeah/helpers/toast_message_helper.dart';
import 'package:al_wasyeah/services/api_client.dart';
import 'package:al_wasyeah/services/api_constants.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/models/property_distribution_calculation_model/relavant_list_model.dart';

class PropertyDistributionCalculationController extends GetxController {
  final Rx<RxStatus> status = RxStatus.loading().obs;

  RxList<RelativeModelForPropertyDistribution> allRelatives =
      <RelativeModelForPropertyDistribution>[].obs;
  RxList<PropertydistributionResultModel> propertyDistributionResult =
      <PropertydistributionResultModel>[].obs;

  // Selection and Counts
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

  RxString goldUnit = "Gram".obs;
  RxString silverUnit = "Gram".obs;

  RxBool isCalculateVisible = false.obs;
  RxBool isCalculateLoading = false.obs;

  final List<String> hiddenRelatives = [
    "Deceased Son's Son",
    "Deceased Son's Daughter",
    "Deceased Daughter's Son",
    "Deceased Daughter's Daughter"
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
    loadRelatives();
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

  void loadRelatives() {
    for (var rel in allRelatives) {
      isChecked[rel.relative!] = false;
      counts[rel.relative!] = 0;
    }
  }

  List<RelativeModelForPropertyDistribution> get filteredRelatives {
    return allRelatives
        .where((rel) => !hiddenRelatives.contains(rel.relative))
        .toList();
  }

  void toggleCheck(String relative, bool? value) {
    if (value == true) {
      if (relative == "Husband" && isChecked["Wife"] == true) {
        ToastMessageHelper.errorMessageShowToster(
            "Husband and wife can't be select togather");
        isChecked["Wife"] = false;
        counts["Wife"] = 0;
      } else if (relative == "Wife" && isChecked["Husband"] == true) {
        ToastMessageHelper.errorMessageShowToster(
            "Husband and wife can't be select togather");
        isChecked["Husband"] = false;
        counts["Husband"] = 0;
      }
      isChecked[relative] = true;
      if (counts[relative] == 0) counts[relative] = 1;

      // Handle special limit for Husband and Father
      if ((relative == "Husband" || relative == "Father") &&
          counts[relative]! > 1) {
        counts[relative] = 1;
      }
    } else {
      isChecked[relative] = false;
      counts[relative] = 0;
    }
    update();
  }

  void increment(String relative) {
    if (isChecked[relative] != true) return;

    if (relative == "Husband" || relative == "Father") {
      if (counts[relative]! >= 1) return;
    }

    counts[relative] = (counts[relative] ?? 0) + 1;
    update();
  }

  void decrement(String relative) {
    if (isChecked[relative] != true) return;
    if (counts[relative]! > 0) {
      counts[relative] = counts[relative]! - 1;
      if (counts[relative] == 0) {
        isChecked[relative] = false;
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
    if (dynamicCounts[key]! > 0) {
      dynamicCounts[key] = dynamicCounts[key]! - 1;
      if (dynamicCounts[key] == 0) {
        dynamicIsChecked[key] = false;
      }
    }
    update();
  }

  void submitCalculation() async {
    Map<String, int> relatives = {};

    // 1. Map standard relatives
    for (var rel in allRelatives) {
      String name = rel.relative!;
      if (isChecked[name] == true) {
        String key = "relative_no_${rel.encrypted}";
        relatives[key] = counts[name] ?? 0;
      }
    }

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
      if (goldUnit.value == "Vori") {
        goldVal = goldVal * 11.664;
      }
      finalOutput["propertyGold"] = goldVal;
    }
    if (silverController.text.isNotEmpty) {
      double silverVal = double.tryParse(silverController.text) ?? 0;
      if (silverUnit.value == "Vori") {
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
            "Calculation fetched successfully");
        propertyDistributionResult.value =
            propertydistributionResultModelFromJson(jsonEncode(response.body));

        // Reset all inputs after success if needed,
        // Note: User asked to clean the selected and typed value.
        resetInputs();
      } else {
        ToastMessageHelper.errorMessageShowToster(
            "Failed to fetch calculation result");
      }
    } catch (e, s) {
      log("Property Calculation Error: $e\nStacktrace: $s");
      ToastMessageHelper.errorMessageShowToster("Something went wrong");
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
    goldUnit.value = "Gram";
    silverUnit.value = "Gram";
    isCalculateVisible.value = false;
    update();
  }

  String _mapDynamicKeyToShortKey(String uiKey) {
    // Regex to parse "Deceased 1st Son's Son" -> parent: son, child: son, index: 1
    // Regex to parse "Deceased 2nd Daughter's Daughter" -> parent: daughter, child: daughter, index: 2

    final pattern = RegExp(
        r"Deceased (\d+)(?:st|nd|rd|th) (Son|Daughter)'s (Son|Daughter)");
    final match = pattern.firstMatch(uiKey);

    if (match != null) {
      int index = int.parse(match.group(1)!);
      String parent = match.group(2)!.toLowerCase();
      String child = match.group(3)!.toLowerCase();
      return "relative_no_${parent}_${child}_$index";
    }

    return uiKey; // Fallback
  }

  String getOrdinal(int n) {
    if (n == 1) return "1st";
    if (n == 2) return "2nd";
    if (n == 3) return "3rd";
    return "${n}th";
  }
}
