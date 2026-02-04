import 'dart:convert';
import 'dart:developer';
import 'package:al_wasyeah/helpers/toast_message_helper.dart';
import 'package:al_wasyeah/services/api_client.dart';
import 'package:al_wasyeah/services/api_constants.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/models/property_distribution_calculation_model/relavant_list_model.dart';

class PropertyDistributionCalculationController extends GetxController {
  final Rx<RxStatus> status = RxStatus.loading().obs;

  RxList<RelevantList> allRelatives = <RelevantList>[].obs;

  // Selection and Counts
  RxMap<String, bool> isChecked = <String, bool>{}.obs;
  RxMap<String, int> counts = <String, int>{}.obs;

  // For dynamic items (Deceased Son/Daughter sub-items)
  // Key format: "Deceased 1st Son's Son" -> count
  RxMap<String, bool> dynamicIsChecked = <String, bool>{}.obs;
  RxMap<String, int> dynamicCounts = <String, int>{}.obs;

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

  List<RelevantList> get filteredRelatives {
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

  String getOrdinal(int n) {
    if (n == 1) return "1st";
    if (n == 2) return "2nd";
    if (n == 3) return "3rd";
    return "${n}th";
  }
}
