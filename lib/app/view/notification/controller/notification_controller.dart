import 'dart:convert';
import 'dart:developer';

import 'package:al_wasyeah/app/view/notification/model/inapp_notification_model.dart';
import 'package:al_wasyeah/app/core/services/api/api_service.dart';
import 'package:al_wasyeah/app/core/utils/api_constants.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController with StateMixin<List<InAppNotificationModel>> {
  @override
  void onInit() {
    super.onInit();
    getNotificationList();
  }

  Future<void> getNotificationList() async {
    change(null, status: RxStatus.loading());

    try {
      var response = await ApiService.getData(ApiConstants.inappnotificationList);

      final data = inAppNotificationModelFromJson(jsonEncode(response.body));

      if (data.isEmpty) {
        change(null, status: RxStatus.empty());
      } else {
        change(data, status: RxStatus.success());
      }
    } catch (e, s) {
      change(null, status: RxStatus.error());
      log("Inapp Notification List Error: $e\nStacktrace: $s");
    }
  }

  Future<void> approveOrDeclienNotification(requestKey, value) async {
    try {
      var response = await ApiService.getData(ApiConstants.inappNOtificationAcceptRejectRequest + "?requestKey=$requestKey&value=$value");

      if (response.statusCode == 200 || response.statusCode == 201) {
        await getNotificationList();
        Get.snackbar("Notification Status", "Updated");
      } else {
        Get.snackbar("Error", response.statusText ?? "Failed to update notification status");
      }
    } catch (e, s) {
      log("Inapp Notification Accept/Reject Error: $e\nStacktrace: $s");
    }
  }
}
