import 'package:al_wasyeah/utils/app_constant.dart';
import 'package:al_wasyeah/view/auth/otp_verify_screen.dart';
import 'package:al_wasyeah/view/home/home_page.dart';
import 'package:get/get.dart';

import '../../helpers/helpers.dart';
import '../../helpers/prefs_helper.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';

class AuthController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    //
  }

  ///==================get Question===========================
  RxBool isQuestion = false.obs;
  RxList<SecurityQuestionResponseModel> securityQuestionResponseModel =
      <SecurityQuestionResponseModel>[].obs;

  getSecurityQuestion() async {
    isQuestion(true);
    var response = await ApiClient.getData(ApiConstants.securityQuestion);
    print("getSecurityQuestion data ------------${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      securityQuestionResponseModel.value =
          List<SecurityQuestionResponseModel>.from(response.body
              .map((x) => SecurityQuestionResponseModel.fromJson(x)));
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
    var headers = {'Content-Type': 'application/json'};
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
    var response = await ApiClient.postData(
      ApiConstants.signUpEndPoint,
      body,
      headers: headers,
    );
    print("regggggggggggggggggggggggggggg${response.body}");
    if (response.statusCode == 200) {
      // await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token'].toString());

      if (response.body["status"] == false) {
        ToastMessageHelper.errorMessageShowToster(response.body?['message']);
      } else {
        ToastMessageHelper.successMessageShowToster(
            AppLocalizations.of(Get.context!)!.account_create_success);
        Get.toNamed(
          AppRoutes.loginPage,
          preventDuplicates: false,
        );
      }
      signUpLoading(false);
    } else if (response.statusCode == 1) {
      signUpLoading(false);
      ToastMessageHelper.errorMessageShowToster(
          AppLocalizations.of(Get.context!)!.server_error);
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

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "username": userName,
        "password": password,
      };

      var response = await ApiClient.postData(
        ApiConstants.signInEndPoint,
        body,
        headers: headers,
      );

      print("log in-----------------${response.body}");

      /// ✅ SUCCESS
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body["status"] == false) {
          ToastMessageHelper.errorMessageShowToster(
            response.body?['message'] ??
                AppLocalizations.of(Get.context!)!.invalid_username_or_password,
          );
        } else {
          final token = response.body?['data']['token'];
          print("token::::---------$token");
          await PrefsHelper.setString(
            AppConstants.bearerToken,
            token.toString(),
          );

          ToastMessageHelper.successMessageShowToster(
            response.body?["message"] ??
                AppLocalizations.of(Get.context!)!.welcome_back,
          );

          Get.offAllNamed(AppRoutes.homePage);
        }
      }

      /// ❌ LOGIN FAILED (401, 403, etc)
      else {
        ToastMessageHelper.errorMessageShowToster(
          response.body?['message'] ??
              AppLocalizations.of(Get.context!)!.invalid_username_or_password,
        );
      }
    } catch (e) {
      /// 💥 ANY UNEXPECTED ERROR
      print("Login error: $e");
      ToastMessageHelper.errorMessageShowToster(
        AppLocalizations.of(Get.context!)!.something_went_wrong,
      );
    } finally {
      /// 🔁 ALWAYS STOP LOADING
      signInLoading(false);
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
    var response = await ApiClient.postData(
      ApiConstants.forgotEndPoint,
      body,
      headers: headers,
    );
    print("log in-----------------${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      //  await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token'].toString());
      //ToastMessageHelper.successMessageShowToster("${response.body["message"]}");
      ToastMessageHelper.successMessageShowToster(
          AppLocalizations.of(Get.context!)!.verification_otp_send_success);

      Get.off(() => OtpVerifyScreen(), preventDuplicates: false);
      forgotLoading(false);
    } else {
      forgotLoading(false);
      ToastMessageHelper.errorMessageShowToster(
          AppLocalizations.of(Get.context!)!.unable_data);
    }
  }
}
