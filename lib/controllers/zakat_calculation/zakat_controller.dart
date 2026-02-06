import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../helpers/helpers.dart';
import '../../services/database_helper.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../../utils/app_constant.dart';
import '../../utils/app_colors.dart';
import '../../view/widgets/widgets.dart';

class ZakatController extends GetxController {
  ///==================get Witness===========================
  final cashAndBankController = TextEditingController();

  RxBool isNisabLoading = false.obs;
  RxList<GetNisabRatesResponseModel> nisabRates =
      <GetNisabRatesResponseModel>[].obs;

  Rx<GetNisabRatesResponseModel?> selectedCurrency =
      Rx<GetNisabRatesResponseModel?>(null);

  @override
  void onInit() {
    super.onInit();
    getNisabRates();
  }

  void getNisabRates() async {
    isNisabLoading(true);
    var response = await ApiClient.get(ApiConstants.nisabEndPoint);
    if (response.statusCode == 200 || response.statusCode == 201) {
      nisabRates.value = List<GetNisabRatesResponseModel>.from(
        response.body.map((x) => GetNisabRatesResponseModel.fromJson(x)),
      );
      if (nisabRates.isNotEmpty) {
        selectedCurrency(nisabRates.first); // Set default

        // Delay updating controller until widget tree is built
        WidgetsBinding.instance.addPostFrameCallback((_) {
          cashAndBankController.text = nisabRates.first.nisabAmount.toString();
        });
      }
    }
    isNisabLoading(false);
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
    var response = await ApiClient.post(
      ApiConstants.zakatEndPoint,
      body,
    );
    print("----------------${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.successMessageShowToster(
          'recordInsertedSuccessfully'.tr);
      print("zakat netAssets${response.body}");
      showZakatDialog(
          assetsAccount: "${response.body["netAssets"]}".tr,
          zakatAccount: "${response.body["zakatAmount"]}".tr);

      // Get.off(() => StepNavigationWithPageView(), preventDuplicates: false);
      zakatLoading(false);
    } else {
      // ToastMessageHelper.errorMessageShowToster("${response.body["message"]}");
      zakatLoading(false);
    }
  }

  void showZakatDialog(
      {required String assetsAccount, required String zakatAccount}) {
    Get.dialog(
      AlertDialog(
        title: CustomText(
          text: 'result'.tr,
          fontsize: 20,
          fontWeight: FontWeight.w600,
        ),
        content: SizedBox(
          width: double.infinity,
          height: 200,
          child: Column(
            children: [
              Divider(),
              CustomText(
                text: 'totalAssets'.tr,
                fontsize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
              SizedBox(height: 12),
              CustomText(
                text: assetsAccount,
                fontsize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
              Divider(color: AppColors.primaryColor),
              CustomText(
                text: 'payableZakat'.tr,
                fontsize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
              SizedBox(height: 12),
              CustomText(
                text: zakatAccount,
                fontsize: 22,
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
