import 'dart:convert';

import 'package:al_wasyeah/models/auths/login_response_model.dart';
import 'package:al_wasyeah/models/auths/registation_response_model.dart';
import 'package:al_wasyeah/models/security_questions/security_question_model.dart';
import 'package:al_wasyeah/services/database_helper.dart';
import 'package:al_wasyeah/services/database_keys.dart';
import 'package:al_wasyeah/view/screen/home_screen.dart';
import 'package:al_wasyeah/view/screen/otp_verify_screen.dart';
import 'package:get/get.dart';

import '../../helpers/helpers.dart';

import '../../services/services.dart';

class AuthController extends GetxService {
  // Save token after login
  static Future<void> saveToken(LoginResponseModel response) async {
    final token = response.data?.token;
    if (token == null || token.isEmpty) return;

    await DatabaseService.instance.put<String>(
      DatabaseKeys.authBox,
      DatabaseKeys.token,
      token,
    );
  }

  // Get token
  static String? getToken() {
    return DatabaseService.instance.get<String>(
      DatabaseKeys.authBox,
      DatabaseKeys.token,
    );
  }

  // Clear token on logout
  static Future<void> clearToken() async {
    await DatabaseService.instance.delete(
      DatabaseKeys.authBox,
      DatabaseKeys.token,
    );
  }

  ///==================get Question===========================

  RxList<SecurityQuestionListModel> securityQuestionResponseModel =
      <SecurityQuestionListModel>[].obs;

  getSecurityQuestion() async {
    var response = await ApiClient.get(ApiConstants.securityQuestionEndPoint);
    if (response.statusCode == 200 || response.statusCode == 201) {
      securityQuestionResponseModel(
          securityQuestionListModelFromJson(jsonEncode(response.body)));
    }
  }

  ///==================Save Sign Up===========================
  RxBool signUpLoading = false.obs;

  Future<void> signUpHandle({
    required bool agreeTerms,
    required String dob,
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    required String securityAnswer,
    required String securityCode,
    required String source,
  }) async {
    signUpLoading(true);
    var headers = {'Content-Type': 'application/json'};
    var body = {
      "agreeTerms": agreeTerms,
      "dob": dob,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "securityAnswer": securityAnswer,
      "securityCode": securityCode,
      "source": source,
    };
    var response = await ApiClient.post(
      ApiConstants.signUpEndPoint,
      body,
      headers: headers,
    );

    if (response.statusCode == 200) {
      RegistrationModel registrationModel =
          registrationModelFromJson(jsonEncode(response.body));

      ToastMessageHelper.successMessageShowToster(
          "Account create successful.\n \nNow you have a user name and password your email.");
      Get.toNamed(
        AppRoutes.loginScreen,
        preventDuplicates: false,
      );
      signUpLoading(false);
    } else if (response.statusCode == 1) {
      signUpLoading(false);
      ToastMessageHelper.errorMessageShowToster(
          "Server error! \n Please try later");
    } else {
      ToastMessageHelper.errorMessageShowToster("${response.body["message"]}");
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
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var body = {
      "username": userName,
      "password": password,
    };
    var response = await ApiClient.post(
      ApiConstants.signInEndPoint,
      body,
      headers: headers,
    );
    LoginResponseModel loginResponseModel =
        loginResponseModelFromJson(jsonEncode(response.body));
    print("log in-----------------${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      loginResponseModel.data?.token;
      ToastMessageHelper.successMessageShowToster(
          "${response.body["message"]}");
      // Get.off(() => StepNavigationWithPageView(), preventDuplicates: false);
      Get.offNamed(AppRoutes.homeScreen);
      signInLoading(false);
    } else {
      signInLoading(false);
      // print(response.body['message']);
      ToastMessageHelper.errorMessageShowToster(
          response.body['message'] ?? 'Login failed. Please try again.');
    }
  }

  ///==================Save Sign Up===========================
  RxBool forgotLoading = false.obs;

  Future<void> forgotHandle({
    required String email,
    required String mobile,
    required String dob,
    required String securityAnswer,
    required String securityCode,
  }) async {
    forgotLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var body = {
      "email": email,
      "mobile": mobile,
      "dob": dob,
      "securityAnswer": securityAnswer,
      "securityCode": securityCode
    };
    var response = await ApiClient.post(
      ApiConstants.forgotEndPoint,
      body,
      headers: headers,
    );
    print("log in-----------------${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      //  await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token'].toString());
      //ToastMessageHelper.successMessageShowToster("${response.body["message"]}");
      ToastMessageHelper.successMessageShowToster(
          "VERIFICATION OTP SEND SUCCESSFULLY!!");

      Get.off(() => OtpVerifyScreen(), preventDuplicates: false);
      forgotLoading(false);
    } else {
      forgotLoading(false);
      ToastMessageHelper.errorMessageShowToster("Unable Data");
    }
  }
}
