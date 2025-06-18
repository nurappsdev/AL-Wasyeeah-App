

import 'dart:convert';

import 'package:al_wasyeah/view/screen/home_screen.dart';
import 'package:al_wasyeah/view/screen/otp_verify_screen.dart';
import 'package:get/get.dart';

import '../../helpers/helpers.dart';
import '../../helpers/prefs_helper.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../../utils/utils.dart';
import '../../view/screen/profile_setting/profile_setting.dart';

class AuthController  extends GetxController{

  @override
  void onInit() {
    super.onInit();
    getSecurityQuestion();
  }
  ///==================get Question===========================
  RxBool isQuestion= false.obs;
  RxList<SecurityQuestionResponseModel> securityQuestionResponseModel = <SecurityQuestionResponseModel>[].obs;
  getSecurityQuestion() async{
    isQuestion(true);
    var response = await ApiClient.getData(ApiConstants.securityQuestionEndPoint);
    print("getSecurityQuestion data ------------${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){
      securityQuestionResponseModel.value = List<SecurityQuestionResponseModel>.from(response.body.map((x)=> SecurityQuestionResponseModel.fromJson(x)));
      isQuestion(false);
    }else{
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
      jsonEncode(body),
      headers: headers,
    );
    print("regggggggggggggggggggggggggggg${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      // await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token'].toString());
      ToastMessageHelper.successMessageShowToster("Account create successful.\n \nNow you have a user name and password your email");
      Get.toNamed(AppRoutes.loginScreen, preventDuplicates: false,);
      signUpLoading(false);
    } else if(response.statusCode == 1){
      signUpLoading(false);
      ToastMessageHelper.errorMessageShowToster("Server error! \n Please try later");
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
    var headers = {'Content-Type': 'application/json'};
    var body = {
      "username": userName,
      "password": password
    };
    var response = await ApiClient.postData(
      ApiConstants.signInEndPoint,
      jsonEncode(body),
      headers: headers,
    );
    print("log in-----------------${response.body}");
    if (response.statusCode == 200) {
       await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token'].toString());

       print("token---------->${PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token'].toString())}");
       ToastMessageHelper.successMessageShowToster("${response.body["message"]}");
      // Get.off(() => StepNavigationWithPageView(), preventDuplicates: false);
       Get.off(() => HomeScreen(), preventDuplicates: false);
      signInLoading(false);

    } else {
      signInLoading(false);
      print(response.body['message']);
      //ToastMessageHelper.errorMessageShowToster(response.body['message'] ?? 'Login failed. Please try again.');

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
    var headers = {'Content-Type': 'application/json'};
    var body = {
      "email": email,
      "mobile": mobile,
      "dob": dob,
      "securityAnswer": securityAnswer,
      "securityCode": securityCode
    };
    var response = await ApiClient.postData(
      ApiConstants.forgotEndPoint,
      jsonEncode(body),
      headers: headers,
    );
    print("log in-----------------${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
    //  await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token'].toString());
      //ToastMessageHelper.successMessageShowToster("${response.body["message"]}");
      ToastMessageHelper.successMessageShowToster("VERIFICATION OTP SEND SUCCESSFULLY!!");
      Get.off(() => OtpVerifyScreen(), preventDuplicates: false);
      forgotLoading(false);
    } else {
      forgotLoading(false);
     ToastMessageHelper.errorMessageShowToster("Unable Data");

    }
  }



}
