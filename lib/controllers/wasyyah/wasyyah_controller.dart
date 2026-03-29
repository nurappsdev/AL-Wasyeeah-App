import 'dart:developer';

import 'package:al_wasyeah/helpers/helpers.dart';
import 'package:al_wasyeah/models/wasyyah/get_wasyyah_response_model.dart';
import 'package:al_wasyeah/services/api_client.dart';
import 'package:al_wasyeah/services/api_constants.dart';
import 'package:al_wasyeah/services/wasyyah_pdf_service.dart';
import 'package:open_file/open_file.dart';
import 'package:get/get.dart';

class WasyyahController extends GetxController {
  final RxList<GetWasyyahResponseModel> wasyyahList =
      <GetWasyyahResponseModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSaveLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getWasyyahData();
  }

  Future<void> getWasyyahData() async {
    isLoading(true);
    try {
      final response = await ApiClient.getData(ApiConstants.wasyyahYouDataYou);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> jsonData = response.body;
        wasyyahList.value = jsonData
            .map((item) => GetWasyyahResponseModel.fromJson(item))
            .toList();
        // Sort items by orderSeq locally
        wasyyahList
            .sort((a, b) => (a.orderSeq ?? 0).compareTo(b.orderSeq ?? 0));
      } else {
        ToastMessageHelper.errorMessageShowToster(
            "Failed to load Wasyyah data");
      }
    } catch (e) {
      ToastMessageHelper.errorMessageShowToster("Network error: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<bool> saveWasiyyah(GetWasyyahResponseModel model) async {
    isSaveLoading(true);
    try {
      final response = await ApiClient.postData(
        ApiConstants.saveWasiyyah,
        model.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        getWasyyahData(); // Refresh list to get updated data if needed
        return true;
      } else {
        ToastMessageHelper.errorMessageShowToster("Failed to save Wasyyah");
        return false;
      }
    } catch (e) {
      ToastMessageHelper.errorMessageShowToster("Network error: $e");
      return false;
    } finally {
      isSaveLoading(false);
    }
  }

  Future<void> toggleVisibility(GetWasyyahResponseModel item) async {
    // Optimistic UI update
    final originalVisibility = item.visible;
    item.visible = (item.visible == "Y" ? "N" : "Y");
    wasyyahList.refresh();

    final success = await saveWasiyyah(item);
    if (!success) {
      // Revert if API failed
      item.visible = originalVisibility;
      wasyyahList.refresh();
    }
  }

  Future<void> updateOrder() async {
    // Map current local list to the required payload format
    final payload = wasyyahList.asMap().entries.map((entry) {
      return {
        "requestKey": entry.value.requestKey,
        "order": entry.key + 1,
      };
    }).toList();

    try {
      final response = await ApiClient.postData(
        ApiConstants.changeOrder,
        payload,
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        ToastMessageHelper.errorMessageShowToster(
            "Failed to sync order with server");
      }
    } catch (e) {
      ToastMessageHelper.errorMessageShowToster(
          "Network error during reorder: $e");
    }
  }

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = wasyyahList.removeAt(oldIndex);
    wasyyahList.insert(newIndex, item);
    wasyyahList.refresh();

    // Sync with backend
    updateOrder();
  }

  Future<void> generateAndPreviewPdf() async {
    isLoading(true);
    try {
      final file = await WasyyahPdfService.generateWasyyahPdf(wasyyahList);
      await OpenFile.open(file.path);
    } catch (e, s) {
      log("PDF ISSUE", error: e, stackTrace: s);
      ToastMessageHelper.errorMessageShowToster("Failed to generate PDF: $e");
    } finally {
      isLoading(false);
    }
  }
}
