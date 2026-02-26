import 'dart:convert';
import 'dart:developer';

import 'package:al_wasyeah/models/notification/inapp_notification_model.dart';
import 'package:al_wasyeah/services/api_client.dart';
import 'package:al_wasyeah/services/api_constants.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController
    with StateMixin<List<InAppNotificationModel>> {
  @override
  void onInit() {
    super.onInit();
    getNotificationList();
  }

  Future<void> getNotificationList() async {
    change(null, status: RxStatus.loading());

    try {
      var response =
          await ApiClient.getData(ApiConstants.inappnotificationList);

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
}
