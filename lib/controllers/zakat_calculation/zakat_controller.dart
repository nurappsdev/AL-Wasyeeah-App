
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../helpers/helpers.dart';
import '../../helpers/prefs_helper.dart';
import '../../services/services.dart';
import '../../utils/utils.dart';
import '../../view/widgets/widgets.dart';

class ZakatController extends GetxController{


  ///==================Save Sign Up===========================
  RxBool zakatLoading = false.obs;
  Future<void> zakatHandle({
     String? goldValue,
     String? silverValue,
     String? cashAndBank,
     String? futureDeposits,
     String? loanGiven,
     String? investmentValue,
     String? rentalIncome,
     String? immediateLiabilities,

  }) async {
    zakatLoading(true);

    String bearerToken = await  PrefsHelper.getString(AppConstants.bearerToken);
    print("token-------${bearerToken}");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    print("token-------${headers}");
    var body = {
      "currencyCode": "bdt",
      "goldValue": goldValue ?? "",
      "silverValue": silverValue ?? "",
      "cashAndBank": cashAndBank ?? "",
      "futureDeposits":futureDeposits ?? "",
      "loanGiven": loanGiven,
      "investmentValue": investmentValue,
      "rentalIncome": rentalIncome,
      "immediateLiabilities": immediateLiabilities
    };
    var response = await ApiClient.postData(
      ApiConstants.zakatEndPoint,
      jsonEncode(body),
      headers: headers,
    );
    print("----------------${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
   ToastMessageHelper.successMessageShowToster("RECORD INSERTED SUCCESSFULLY!!");
      print("zakat netAssets${response.body}");
      showZakatDialog( assetsAccount:"${response.body["netAssets"]}".tr,zakatAccount:"${response.body["zakatAmount"]}".tr );

      // Get.off(() => StepNavigationWithPageView(), preventDuplicates: false);
      zakatLoading(false);

    } else {
     // ToastMessageHelper.errorMessageShowToster("${response.body["message"]}");
      zakatLoading(false);
    }
  }

  void showZakatDialog({required String assetsAccount, required String zakatAccount}) {
    Get.dialog(
      AlertDialog(
        title: CustomText(
          text: "Result".tr,
          fontsize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        content: SizedBox(
          width: double.infinity,
          height: 200.h,
          child: Column(
            children: [
              Divider(),
              CustomText(
                text: "Total Assets".tr,
                fontsize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
              SizedBox(height: 12.h),
              CustomText(
                text: assetsAccount,
                fontsize: 22.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
              Divider(color: AppColors.primaryColor),
              CustomText(
                text: "PAYABLE ZAKAT".tr,
                fontsize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
              SizedBox(height: 12.h),
              CustomText(
                text: zakatAccount,
                fontsize: 22.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

}