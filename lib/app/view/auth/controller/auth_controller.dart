import 'dart:developer';

import 'package:al_wasyeah/app/core/route/route_names.dart';
import 'package:al_wasyeah/app/core/utils/toast_message.dart';
import 'package:al_wasyeah/app/view/auth/model/security_question_response_model.dart';
import 'package:al_wasyeah/app/core/services/api/api_service.dart';
import 'package:al_wasyeah/app/core/utils/api_constants.dart';
import 'package:al_wasyeah/app/core/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/shared_pref/prefs_service.dart';
import 'package:al_wasyeah/app/core/l10n/app_localizations.dart';

class AuthController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    //
  }

  ///==================get Question===========================
  RxBool isQuestion = false.obs;
  RxBool otpStatusLoading = false.obs;
  RxList<SecurityQuestionResponseModel> securityQuestionResponseModel = <SecurityQuestionResponseModel>[].obs;
  final TextEditingController otpController = TextEditingController();

  getSecurityQuestion() async {
    isQuestion(true);
    var response = await ApiService.getData(ApiConstants.securityQuestion);

    if (response.statusCode == 200 || response.statusCode == 201) {
      securityQuestionResponseModel.value = List<SecurityQuestionResponseModel>.from(response.body.map((x) => SecurityQuestionResponseModel.fromJson(x)));
      isQuestion(false);
    } else {
      isQuestion(false);
    }
  }

  ///==================Save Sign Up===========================
  RxBool signUpLoading = false.obs;

  Future<void> signUpHandle({
    required String firstName,
    required String lastName,
    required String email,
    required String mobile,
    required String dob,
    required String userTypeId,
    required String securityCode,
    required String securityAnswer,
    required String source,
  }) async {
    signUpLoading(true);
    var body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "mobile": mobile,
      "dob": dob,
      "userTypeId": userTypeId,
      "securityCode": securityCode,
      "securityAnswer": securityAnswer,
      "source": source,
    };
    var response = await ApiService.postData(
      ApiConstants.signUpEndPoint,
      body,
    );

    if (response.statusCode == 200) {
      // await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token'].toString());

      if (response.body["status"] == false) {
        ToastMessage.errorMessageShowToster(response.body?['message']);
      } else {
        ToastMessage.successMessageShowToster(AppLocalizations.of(Get.context!)!.account_create_success);
        Get.toNamed(
          RouteName.loginPage,
          preventDuplicates: false,
        );
      }
      signUpLoading(false);
    } else if (response.statusCode == 1) {
      signUpLoading(false);
      ToastMessage.errorMessageShowToster(AppLocalizations.of(Get.context!)!.server_error);
    } else {
      ToastMessage.errorMessageShowToster("${response.body["message"]}");
      signUpLoading(false);
    }
  }

  ///==================Save Sign Up===========================
  RxBool signInLoading = false.obs;

  Future<void> signInHandle({
    required String userName,
    required String password,
  }) async {
    signInLoading(true);

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "username": userName,
        "password": password,
      };

      var response = await ApiService.postData(
        ApiConstants.signInEndPoint,
        body,
        headers: headers,
      );

      print("log in-----------------${response.body}");

      /// ✅ SUCCESS
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body["status"] == false) {
          ToastMessage.errorMessageShowToster(
            response.body?['message'] ?? AppLocalizations.of(Get.context!)!.invalid_username_or_password,
          );
        } else {
          final token = response.body?['data']['token'];
          print("token::::---------$token");
          await PrefsHelper.setString(
            AppConstants.bearerToken,
            token.toString(),
          );

          ToastMessage.successMessageShowToster(
            response.body?["message"] ?? AppLocalizations.of(Get.context!)!.welcome_back,
          );

          Get.offAllNamed(RouteName.homePage);
        }
      }

      /// ❌ LOGIN FAILED (401, 403, etc)
      else {
        ToastMessage.errorMessageShowToster(
          response.body?['message'] ?? AppLocalizations.of(Get.context!)!.invalid_username_or_password,
        );
      }
    } catch (e) {
      /// 💥 ANY UNEXPECTED ERROR
      print("Login error: $e");
      ToastMessage.errorMessageShowToster(
        AppLocalizations.of(Get.context!)!.something_went_wrong,
      );
    } finally {
      /// 🔁 ALWAYS STOP LOADING
      signInLoading(false);
    }
  }

  ///==================Save Sign Up===========================
  RxBool forgotLoading = false.obs;

  Future<void> sendOtp({
    required String email,
    required String mobile,
    required String dob,
    required String securityAnswer,
    required String securityCode,
  }) async {
    forgotLoading(true);

    var body = {"email": email, "mobile": mobile, "dob": dob, "securityAnswer": securityAnswer, "securityCode": securityCode};
    var response = await ApiService.postData(
      ApiConstants.sendOtpEndPoint,
      body,
    );
    print("log in-----------------${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      //  await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token'].toString());
      //ToastMessageHelper.successMessageShowToster("${response.body["message"]}");
      ToastMessage.successMessageShowToster(AppLocalizations.of(Get.context!)!.verification_otp_send_success);

      Get.toNamed(RouteName.otpPage, preventDuplicates: false, arguments: {"email": email, "mobile": mobile});
      forgotLoading(false);
    } else {
      forgotLoading(false);
      ToastMessage.errorMessageShowToster(AppLocalizations.of(Get.context!)!.unable_data);
    }
  }

  void verifyOtp({required String otp, required String email, required String mobile}) async {
    otpStatusLoading(true);

    try {
      var response = await ApiService.getData(
        ApiConstants.checkOtpEndPoint + "/?email=$email&mobile=$mobile&otp=$otp",
      );
      log("OTP RESULT-----------------${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessage.successMessageShowToster(AppLocalizations.of(Get.context!)!.verification_otp_send_success);

        Get.toNamed(
          RouteName.loginPage,
          preventDuplicates: false,
        );
        otpStatusLoading(false);
      } else {
        otpStatusLoading(false);
        ToastMessage.errorMessageShowToster(AppLocalizations.of(Get.context!)!.unable_data);
      }
    } catch (e, s) {
      log("OTP ERROR-----------------${e.toString() + s.toString()}");
      otpStatusLoading(false);
      ToastMessage.errorMessageShowToster(AppLocalizations.of(Get.context!)!.unable_data);
    }
  }
}
