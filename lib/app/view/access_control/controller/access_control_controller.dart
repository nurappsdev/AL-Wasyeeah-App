import 'dart:convert';
import 'dart:developer';
import 'package:wasiyyat/app/core/utils/toast_message.dart';
import 'package:wasiyyat/app/view/access_control/model/access_control_user_model.dart';
import 'package:wasiyyat/app/view/access_control/model/context_model.dart';
import 'package:wasiyyat/app/view/access_control/model/user_context_model.dart';
import 'package:wasiyyat/app/view/access_control/model/witness_nominee_context_data_model.dart';
import 'package:wasiyyat/app/core/utils/api_constants.dart';
import 'package:wasiyyat/app/core/services/api/api_service.dart';
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
  final Rx<RxStatus> usersStatus = RxStatus.empty().obs;

  final Rx<WitnessNomineeContextDataModel> witnessNomineeContextData =
      WitnessNomineeContextDataModel().obs;

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
    usersStatus.value = RxStatus.loading();
    usersList.clear();
    userSelectedContexts.clear();
    userHasChanges.clear();

    String isWitnessParam = selectedRole.value == "Witness" ? "1" : "2";

    try {
      final response = await ApiService.getData(
          "${ApiConstants.accessControl}$isWitnessParam");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonEncode(response.body);
        usersList.value = accessControlUserModelFromJson(data);
        if (usersList.isEmpty) {
          usersStatus.value = RxStatus.empty();
        } else {
          usersStatus.value = RxStatus.success();
        }
      } else {
        usersStatus.value =
            RxStatus.error(response.body?.toString() ?? "Failed to load users");
        ToastMessage.errorMessageShowToster("Failed to load users");
      }
    } catch (e) {
      usersStatus.value = RxStatus.error(e.toString());
      ToastMessage.errorMessageShowToster(e.toString());
    } finally {
      isUsersLoading.value = false;
      if (usersStatus.value.isLoading) {
        usersStatus.value = RxStatus.empty();
      }
    }
  }

  Future<void> fetchContextsData(String requestKey) async {
    try {
      if (allContexts.isEmpty) {
        final response = await ApiService.getData(ApiConstants.accessFeature);
        if (response.statusCode == 200 || response.statusCode == 201) {
          final data = jsonEncode(response.body);
          allContexts.value = contextModelFromJson(data);
        }
      }

      if (!userSelectedContexts.containsKey(requestKey)) {
        loadingContextUsers.add(requestKey);
        final userContextRes = await ApiService.getData(
            "${ApiConstants.accessSelect}?requestKey=$requestKey&trace=false");
        if (userContextRes.statusCode == 200 ||
            userContextRes.statusCode == 201) {
          final data = jsonEncode(userContextRes.body);
          final userContexts = userContextModelFromJson(data);
          if (userContexts.isNotEmpty) {
            userSelectedContexts[requestKey] =
                userContexts.map((e) => e.key!).toList();
          } else {
            userSelectedContexts[requestKey] = [];
          }
          userHasChanges[requestKey] = false;
        }
      }
    } catch (e) {
      log("Error fetching contexts for $requestKey: $e");
      ToastMessage.errorMessageShowToster(e.toString());
    } finally {
      loadingContextUsers.remove(requestKey);
    }
  }

  Future<void> fetchContextsPanelData(String requestKey) async {
    contextsPanelDataStatus.value = RxStatus.loading();

    try {
      final response = await ApiService.getData(
          "${ApiConstants.accessControlPanelData}?requestKey=$requestKey");

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Data is : ${response.body}");
        final data = jsonEncode(response.body);
        witnessNomineeContextData.value =
            witnessNomineeContextDataModelFromJson(data);

        final val = witnessNomineeContextData.value;
        bool hasData = val.zakat != null ||
            (val.propertyResult != null && val.propertyResult!.isNotEmpty) ||
            (val.wasiyaaContent != null && val.wasiyaaContent!.isNotEmpty);

        if (hasData) {
          contextsPanelDataStatus.value = RxStatus.success();
        } else {
          contextsPanelDataStatus.value = RxStatus.empty();
        }
        log("Data of access control panel: ${witnessNomineeContextData.value.toJson()}");
      } else {
        contextsPanelDataStatus.value = RxStatus.error(
            response.body?.toString() ??
                "Failed to load access control panel data");
      }
    } catch (error, stackTrace) {
      log("Error is : $error", error: error, stackTrace: stackTrace);
      contextsPanelDataStatus.value = RxStatus.error(error.toString());
      ToastMessage.errorMessageShowToster(error.toString());
    } finally {
      if (contextsPanelDataStatus.value.isLoading) {
        contextsPanelDataStatus.value = RxStatus.empty();
      }
    }
  }

  void toggleContext(String requestKey, int contextId, bool isChecked) {
    List<int> currentSelections =
        List.from(userSelectedContexts[requestKey] ?? []);
    if (isChecked) {
      if (!currentSelections.contains(contextId))
        currentSelections.add(contextId);
    } else {
      currentSelections.remove(contextId);
    }
    userSelectedContexts[requestKey] = currentSelections;
    userHasChanges[requestKey] = true;
  }

  Future<void> saveAllChanges() async {
    List<String> changedUserKeys =
        userHasChanges.entries.where((e) => e.value).map((e) => e.key).toList();

    if (changedUserKeys.isEmpty) return;

    isSaving.value = true;
    bool allSuccess = true;
    String isWitnessParam = selectedRole.value == "Witness" ? "1" : "2";

    try {
      for (String key in changedUserKeys) {
        Map<String, dynamic> body = {
          "requestKey": key,
          "contextIds": userSelectedContexts[key] ?? []
        };

        var response = await ApiService.postData(
          "${ApiConstants.addFeatureNomineeWitnessPoint}$isWitnessParam",
          body: body,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          userHasChanges[key] = false;
        } else {
          allSuccess = false;
        }
      }

      if (allSuccess) {
        ToastMessage.successMessageShowToster("All changes saved successfully");
      } else {
        ToastMessage.errorMessageShowToster("Some changes failed to save");
      }
    } catch (e) {
      ToastMessage.errorMessageShowToster("An error occurred while saving");
    } finally {
      isSaving.value = false;
    }
  }
}
