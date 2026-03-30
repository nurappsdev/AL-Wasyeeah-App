import 'dart:convert';
import 'dart:developer';
import 'package:al_wasyeah/app/models/access_control/access_control_user_model.dart';
import 'package:al_wasyeah/app/models/access_control/context_model.dart';
import 'package:al_wasyeah/app/models/access_control/user_context_model.dart';
import 'package:al_wasyeah/app/models/access_control/witness_nominee_context_data_model.dart';
import 'package:al_wasyeah/core/services/api_constants.dart';
import 'package:al_wasyeah/core/services/api_client.dart';
import 'package:al_wasyeah/core/services/toast_message_helper.dart';
import 'package:get/get.dart';

class AccessControlController extends GetxController {
  Rx<String?> selectedRole = Rx<String?>(null);

  RxList<AccessControlUserModel> usersList = <AccessControlUserModel>[].obs;
  RxList<ContextModel> allContexts = <ContextModel>[].obs;

  RxMap<String, List<int>> userSelectedContexts = <String, List<int>>{}.obs;

  RxList<String> loadingContextUsers = <String>[].obs;

  RxMap<String, bool> userHasChanges = <String, bool>{}.obs;

  bool get hasAnyChanges => userHasChanges.values.any((changed) => changed);

  final Rx<RxStatus> contextsPanelDataStatus = RxStatus.loading().obs;

  final Rx<WitnessNomineeContextDataModel> witnessNomineeContextData = WitnessNomineeContextDataModel().obs;

  RxBool isUsersLoading = false.obs;
  RxBool isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    ever(selectedRole, (role) {
      if (role != null) {
        getUsersByRole();
      }
    });
  }

  Future<void> getUsersByRole() async {
    if (selectedRole.value == null) return;

    isUsersLoading.value = true;
    usersList.clear();
    userSelectedContexts.clear();
    userHasChanges.clear();

    String isWitnessParam = selectedRole.value == "Witness" ? "1" : "2";

    var response = await ApiClient.getData("${ApiConstants.accessControl}$isWitnessParam");

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonEncode(response.body);
      usersList.value = accessControlUserModelFromJson(data);
    } else {
      ToastMessageHelper.errorMessageShowToster("Failed to load users");
    }

    isUsersLoading.value = false;
  }

  Future<void> fetchContextsData(String requestKey) async {
    if (allContexts.isEmpty) {
      var response = await ApiClient.getData(ApiConstants.accessFeature);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonEncode(response.body);
        allContexts.value = contextModelFromJson(data);
      }
    }

    if (!userSelectedContexts.containsKey(requestKey)) {
      loadingContextUsers.add(requestKey);
      var userContextRes = await ApiClient.getData("${ApiConstants.accessSelect}?requestKey=$requestKey&trace=false");
      if (userContextRes.statusCode == 200 || userContextRes.statusCode == 201) {
        var data = jsonEncode(userContextRes.body);
        var userContexts = userContextModelFromJson(data);
        if (userContexts.isNotEmpty) {
          userSelectedContexts[requestKey] = userContexts.map((e) => e.key!).toList();
        } else {
          userSelectedContexts[requestKey] = [];
        }
        userHasChanges[requestKey] = false;
      }
      loadingContextUsers.remove(requestKey);
    }
  }

  Future<void> fetchContextsPanelData(String requestKey) async {
    contextsPanelDataStatus(RxStatus.loading());

    try {
      var response = await ApiClient.getData(ApiConstants.accessControlPanelData + "?requestKey=$requestKey");

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Data is : ${response.body}");
        var data = jsonEncode(response.body);
        witnessNomineeContextData(witnessNomineeContextDataModelFromJson(data));
        contextsPanelDataStatus(RxStatus.success());
        log("Data of access control panel: ${witnessNomineeContextData.value.toJson()}");
      } else {
        contextsPanelDataStatus(RxStatus.empty());
      }
    } catch (error, stackTrace) {
      log("Error is : ${error}");
      log("Stack trace is : ${stackTrace}");
      contextsPanelDataStatus(RxStatus.error(error.toString()));
    }
  }

  void toggleContext(String requestKey, int contextId, bool isChecked) {
    List<int> currentSelections = List.from(userSelectedContexts[requestKey] ?? []);
    if (isChecked) {
      if (!currentSelections.contains(contextId)) currentSelections.add(contextId);
    } else {
      currentSelections.remove(contextId);
    }
    userSelectedContexts[requestKey] = currentSelections;
    userHasChanges[requestKey] = true;
  }

  Future<void> saveAllChanges() async {
    List<String> changedUserKeys = userHasChanges.entries.where((e) => e.value).map((e) => e.key).toList();

    if (changedUserKeys.isEmpty) return;

    isSaving.value = true;
    bool allSuccess = true;
    String isWitnessParam = selectedRole.value == "Witness" ? "1" : "2";

    try {
      for (String key in changedUserKeys) {
        Map<String, dynamic> payload = {"requestKey": key, "contextIds": userSelectedContexts[key] ?? []};

        var response = await ApiClient.postData("${ApiConstants.addFeatureNomineeWitnessPoint}$isWitnessParam", payload);

        if (response.statusCode == 200 || response.statusCode == 201) {
          userHasChanges[key] = false;
        } else {
          allSuccess = false;
        }
      }

      if (allSuccess) {
        ToastMessageHelper.successMessageShowToster("All changes saved successfully");
      } else {
        ToastMessageHelper.errorMessageShowToster("Some changes failed to save");
      }
    } catch (e) {
      ToastMessageHelper.errorMessageShowToster("An error occurred while saving");
    } finally {
      isSaving.value = false;
    }
  }
}
