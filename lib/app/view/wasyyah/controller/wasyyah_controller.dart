import 'dart:developer';
import 'dart:io';

import 'package:al_wasyeah/app/core/l10n/app_localizations.dart';
import 'package:al_wasyeah/app/core/utils/toast_message.dart';
import 'package:al_wasyeah/app/view/wasyyah/model/wasyyah_model.dart';
import 'package:al_wasyeah/app/core/services/api/api_service.dart';
import 'package:al_wasyeah/app/core/utils/api_constants.dart';
import 'package:al_wasyeah/app/core/services/pdf/pdf_service.dart';
import 'package:get/get.dart';

class WasyyahController extends GetxController {
  final RxList<WasyyahContentModel> wasyyahList = <WasyyahContentModel>[].obs;
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
      final response = await ApiService.getData(ApiConstants.wasyyahYouDataYou);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> jsonData = response.body;
        wasyyahList.value = jsonData.map((item) => WasyyahContentModel.fromJson(item)).toList();
        // Sort items by orderSeq locally
        wasyyahList.sort((a, b) => (a.orderSeq ?? 0).compareTo(b.orderSeq ?? 0));
      } else {
        ToastMessage.errorMessageShowToster(AppLocalizations.of(Get.context!)!.failed_to_load_wasiyyah_data);
      }
    } catch (e) {
      ToastMessage.errorMessageShowToster(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<bool> saveWasiyyah(WasyyahContentModel model) async {
    isSaveLoading(true);
    try {
      final response = await ApiService.postData(
        ApiConstants.saveWasiyyah,
        model.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        getWasyyahData(); // Refresh list to get updated data if needed
        return true;
      } else {
        ToastMessage.errorMessageShowToster(AppLocalizations.of(Get.context!)!.failed_to_save_wasiyyah);
        return false;
      }
    } catch (e) {
      ToastMessage.errorMessageShowToster(e.toString());
      return false;
    } finally {
      isSaveLoading(false);
    }
  }

  Future<void> toggleVisibility(WasyyahContentModel item) async {
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

  Future<void> updateWasiyyah() async {
    // Map current local list to the required payload format
    final payload = wasyyahList.asMap().entries.map((entry) {
      return {
        "requestKey": entry.value.requestKey,
        "order": entry.key + 1,
      };
    }).toList();

    try {
      final response = await ApiService.postData(
        ApiConstants.changeOrder,
        payload,
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        ToastMessage.errorMessageShowToster(AppLocalizations.of(Get.context!)!.failed_to_update_wasiyyah);
      }
    } catch (e) {
      ToastMessage.errorMessageShowToster(e.toString());
    }
  }

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = wasyyahList.removeAt(oldIndex);
    wasyyahList.insert(newIndex, item);
    wasyyahList.refresh();

    // Sync with backend
    updateWasiyyah();
  }

  Future<File?> generatePdfFile() async {
    isLoading(true);
    try {
      final file = await PdfService.generateWasyyahPdf(wasyyahList);

      return file;
    } catch (e, s) {
      log("PDF ISSUE", error: e, stackTrace: s);
      ToastMessage.errorMessageShowToster(AppLocalizations.of(Get.context!)!.failed_to_generate_pdf);
      return null;
    } finally {
      isLoading(false);
    }
  }
}
