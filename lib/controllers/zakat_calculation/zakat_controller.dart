import 'dart:convert';

import 'package:al_wasyeah/models/zakat_cal/zakat_calculation_result_model.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/utils/app_constant.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../helpers/helpers.dart';
import '../../helpers/prefs_helper.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';

class ZakatController extends GetxController with StateMixin<dynamic> {
  ///==================get Witness===========================
  final cashAndBankController = TextEditingController();

  RxBool isNisabLoading = false.obs;
  RxList<GetNisabRatesResponseModel> nisabRates = <GetNisabRatesResponseModel>[].obs;
  Rx<ZakatCalculationResultModel?> zakatCalculationResult = Rx<ZakatCalculationResultModel?>(null);

  Rx<GetNisabRatesResponseModel?> selectedCurrency = Rx<GetNisabRatesResponseModel?>(null);

  @override
  void onInit() {
    super.onInit();
    getNisabRates();
  }

  /// Currency sign derived from selectedCurrency
  String get currencySign => selectedCurrency.value?.currencyIcon ?? '';

  void getNisabRates() async {
    change(null, status: RxStatus.loading());

    var response = await ApiClient.getData(ApiConstants.nisabEndPoint);
    if (response.statusCode == 200 || response.statusCode == 201) {
      nisabRates(getNisabRatesResponseModelFromJson(jsonEncode(response.body)));
    }

    change(null, status: RxStatus.success());
  }

  void onCurrencySelected(GetNisabRatesResponseModel value) {
    selectedCurrency(value);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cashAndBankController.text = value.nisabAmount.toString();
    });
  }

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

    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    print("token-------${bearerToken}");
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $bearerToken'};
    print("token-------${headers}");
    var body = {
      "currencyCode": "bdt",
      "goldValue": goldValue ?? "",
      "silverValue": silverValue ?? "",
      "cashAndBank": cashAndBank ?? "",
      "futureDeposits": futureDeposits ?? "",
      "loanGiven": loanGiven,
      "investmentValue": investmentValue,
      "rentalIncome": rentalIncome,
      "immediateLiabilities": immediateLiabilities
    };
    var response = await ApiClient.postData(
      ApiConstants.zakatEndPoint,
      body,
      headers: headers,
    );

    print("----------------${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      zakatCalculationResult(zakatCalculationResultModelFromJson(jsonEncode(response.body)));
      ToastMessageHelper.successMessageShowToster(AppLocalizations.of(Get.context!)!.record_inserted_successfully);

      showZakatDialog(Get.context, assetsAccount: "${zakatCalculationResult.value?.netAssets.toLocal()}", zakatAccount: "${zakatCalculationResult.value?.zakatAmount.toLocal()}");

      // Get.off(() => StepNavigationWithPageView(), preventDuplicates: false);
      zakatLoading(false);
    } else {
      // ToastMessageHelper.errorMessageShowToster("${response.body["message"]}");
      zakatLoading(false);
    }
  }

  void showZakatDialog(context, {required String assetsAccount, required String zakatAccount}) {
    Get.dialog(
      AlertDialog(
        title: CustomText(
          text: AppLocalizations.of(context)!.result,
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
                text: AppLocalizations.of(context)!.total_assets,
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
                text: AppLocalizations.of(context)!.payable_zakat,
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
