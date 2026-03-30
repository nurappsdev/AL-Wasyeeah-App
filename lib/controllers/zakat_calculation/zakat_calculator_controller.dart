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

class ZakatCalculatorController extends GetxController with StateMixin<dynamic> {
  ///==================get Witness===========================
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final cashAndBankController = TextEditingController();
  final TextEditingController valueGoldController = TextEditingController();

  final TextEditingController valueSilverController = TextEditingController();

  final TextEditingController futureDepositsController = TextEditingController();

  final TextEditingController loanGivenController = TextEditingController();

  final TextEditingController investmentValueController = TextEditingController();

  final TextEditingController rentalIncomeController = TextEditingController();

  final TextEditingController immediateLiabilitieseController = TextEditingController();

  RxBool isNisabLoading = false.obs;
  RxList<GetNisabRatesResponseModel> nisabRates = <GetNisabRatesResponseModel>[].obs;
  Rx<ZakatCalculationResultModel?> zakatCalculationResult = Rx<ZakatCalculationResultModel?>(null);

  Rx<GetNisabRatesResponseModel?> selectedCurrency = Rx<GetNisabRatesResponseModel?>(null);

  @override
  void onInit() {
    super.onInit();
    getNisabRates();
  }

  @override
  void dispose() {
    cashAndBankController.dispose();
    valueGoldController.dispose();
    valueSilverController.dispose();
    futureDepositsController.dispose();
    loanGivenController.dispose();
    investmentValueController.dispose();
    rentalIncomeController.dispose();
    immediateLiabilitieseController.dispose();
    super.dispose();
  }

  /// Currency sign derived from selectedCurrency
  String get currencySign => selectedCurrency.value?.currencyIcon ?? '';

  void getNisabRates() async {
    change(null, status: RxStatus.loading());

    try {
      var response = await ApiClient.getData(ApiConstants.nisab);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = getNisabRatesResponseModelFromJson(jsonEncode(response.body));
        nisabRates(data);

        change(data, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error("Failed to load"));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void onCurrencySelected(GetNisabRatesResponseModel value) {
    selectedCurrency(value);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cashAndBankController.text = value.nisabAmount.toString();
    });
  }

  RxBool zakatLoading = false.obs;
  Future<void> calculateZakatAmount() async {
    zakatLoading(true);

    var body = {
      "currencyCode": "bdt",
      "goldValue": valueGoldController.text,
      "silverValue": valueSilverController.text,
      "cashAndBank": cashAndBankController.text,
      "futureDeposits": futureDepositsController.text,
      "loanGiven": loanGivenController.text,
      "investmentValue": investmentValueController.text,
      "rentalIncome": rentalIncomeController.text,
      "immediateLiabilities": immediateLiabilitieseController.text
    };
    var response = await ApiClient.postData(
      ApiConstants.zakatEndPoint,
      body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      zakatCalculationResult(zakatCalculationResultModelFromJson(jsonEncode(response.body)));
      ToastMessageHelper.successMessageShowToster(AppLocalizations.of(Get.context!)!.record_inserted_successfully);

      showZakatDialog(Get.context, assetsAccount: "${zakatCalculationResult.value?.netAssets.toLocal()}", zakatAccount: "${zakatCalculationResult.value?.zakatAmount.toLocal()}");

      zakatLoading(false);
    } else {
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
                text: assetsAccount + " (${selectedCurrency.value?.currencyIcon})",
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
                text: zakatAccount + " (${selectedCurrency.value?.currencyIcon})",
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
