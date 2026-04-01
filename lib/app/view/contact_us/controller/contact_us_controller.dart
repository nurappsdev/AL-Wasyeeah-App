import 'dart:developer';
import 'package:al_wasyeah/app/core/l10n/app_localizations.dart';
import 'package:al_wasyeah/app/core/services/api/api_service.dart';
import 'package:al_wasyeah/app/core/utils/api_constants.dart';
import 'package:al_wasyeah/app/core/utils/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<RxStatus> status = RxStatus.empty().obs;
  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
  }

  void submitContactForm() async {
    status(RxStatus.loading());
    if (formKey.currentState!.validate()) {
      // Process the form
      print('Name: ${nameController.text}');
      print('Email: ${emailController.text}');
      print('Phone: ${phoneController.text}');
      print('Message: ${messageController.text}');

      try {
        var body = {"name": nameController.text.trim(), "mobile": phoneController.text.trim(), "email": emailController.text.trim(), "message": messageController.text.trim()};
        var response = await ApiService.postData(
          ApiConstants.contactUsEndPoint,
          body,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          // await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token'].toString());

          ToastMessage.successMessageShowToster(AppLocalizations.of(Get.context!)!.message_send_success);
          status(RxStatus.success());
        }
      } catch (error, stackTrace) {
        log(error.toString());
        log(stackTrace.toString());
        status(RxStatus.empty());
        ToastMessage.errorMessageShowToster(
          error.toString(),
        );
      }
    } else {
      ToastMessage.errorMessageShowToster(
        AppLocalizations.of(Get.context!)!.please_fill_all_the_fields,
      );
    }
  }
}
