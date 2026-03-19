import 'package:al_wasyeah/controllers/zakat_calculation/zakat_calculator_controller.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/utils/app_dimentions.dart';
import 'package:al_wasyeah/view/widgets/background_image_screen_widget.dart';
import 'package:al_wasyeah/view/widgets/custom_button_common.dart';
import 'package:al_wasyeah/view/widgets/custom_loader.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:al_wasyeah/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';

import 'package:al_wasyeah/l10n/app_localizations.dart';

class ZakatCalculatorScreen extends GetView<ZakatCalculatorController> {
  ZakatCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppLocalizations.of(context)!.calculate_your_zakat_easily,
          fontsize: 18.sp,
        ),
      ),
      body: BackgroundImageContainer(
        child: controller.obx(
          (state) => _buildContent(context, isLoading: false),
          onLoading: _buildContent(context, isLoading: true),
          onError: (err) => ErrorWidget(Exception(err)),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, {required bool isLoading}) {
    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        width: double.infinity,
        height: Get.height,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Obx(() {
                    if (controller.isNisabLoading.value) {
                      return const CustomLoader();
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "${AppLocalizations.of(context)!.currency} *",
                          fontsize: 16.sp,
                          fontWeight: FontWeight.w900,
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<GetNisabRatesResponseModel>(
                          isExpanded: true,
                          value: controller.selectedCurrency.value,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.currency,
                            labelStyle: TextStyle(fontWeight: FontWeight.w900),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                          ),
                          items: controller.nisabRates.map((model) {
                            return DropdownMenuItem(
                              value: model,
                              child: CustomText(
                                text:
                                    "${model.currencyCode} - ${model.currencyIcon}",
                                fontsize: 16.sp,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              controller.onCurrencySelected(value);
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }),
                  SizedBox(
                    height: 12.h,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Obx(() {
                    final currency = controller.selectedCurrency.value;
                    final bool isDisabled = currency == null;

                    String nisabLabel = AppLocalizations.of(context)!.nisab;
                    if (!isDisabled) {
                      final updatedDate = controller.nisabRates
                          .where((element) => element.id == currency.id)
                          .first
                          .insertAt;
                      final formattedDate = DateFormat(
                        'yyyy-MM-dd',
                        Get.locale!.languageCode,
                      ).format(updatedDate!);
                      nisabLabel =
                          "${AppLocalizations.of(context)!.nisab} (${AppLocalizations.of(context)!.updated} $formattedDate)";
                    }

                    return IgnorePointer(
                      ignoring: isDisabled,
                      child: Opacity(
                        opacity: isDisabled ? 0.4 : 1.0,
                        child: Container(
                          height: 100.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: AppColors.primaryColor),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.radiusExtraLarge.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4.h),
                                CustomText(
                                  text: nisabLabel,
                                  fontsize: 16.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(4.r),
                                  child: CustomTextField(
                                    readOnly: isDisabled,
                                    controller:
                                        controller.cashAndBankController,
                                    hintText: AppLocalizations.of(context)!
                                        .nisab_amount,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    height: 20.h,
                  ),
                  Obx(() {
                    final bool isDisabled =
                        controller.selectedCurrency.value == null;
                    return IgnorePointer(
                      ignoring: isDisabled,
                      child: Opacity(
                        opacity: isDisabled ? 0.4 : 1.0,
                        child: Container(
                          height: 450.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: AppColors.primaryColor),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.radiusExtraLarge.w),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h),
                                  CustomText(
                                    text: AppLocalizations.of(context)!
                                            .value_of_gold +
                                        " (${controller.selectedCurrency.value?.currencyIcon})",
                                    fontsize: 16.sp,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4.r),
                                    child: CustomTextField(
                                      keyboardType: TextInputType.number,
                                      controller:
                                          controller.valueGoldController,
                                      readOnly: isDisabled,
                                      hintText: AppLocalizations.of(context)!
                                              .value_of_gold +
                                          " (${controller.selectedCurrency.value?.currencyIcon})",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  CustomText(
                                    text: AppLocalizations.of(context)!
                                            .value_of_silver +
                                        " (${controller.selectedCurrency.value?.currencyIcon})",
                                    fontsize: 16.sp,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4.r),
                                    child: CustomTextField(
                                      keyboardType: TextInputType.number,
                                      controller:
                                          controller.valueSilverController,
                                      readOnly: isDisabled,
                                      hintText: AppLocalizations.of(context)!
                                              .value_of_silver +
                                          " (${controller.selectedCurrency.value?.currencyIcon})",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  CustomText(
                                    text: AppLocalizations.of(context)!
                                            .future_deposits +
                                        " (${controller.selectedCurrency.value?.currencyIcon})",
                                    fontsize: 16.sp,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4.r),
                                    child: CustomTextField(
                                      keyboardType: TextInputType.number,
                                      controller:
                                          controller.futureDepositsController,
                                      readOnly: isDisabled,
                                      hintText: AppLocalizations.of(context)!
                                              .future_deposits +
                                          " (${controller.selectedCurrency.value?.currencyIcon})",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  CustomText(
                                    text: AppLocalizations.of(context)!
                                            .given_out_in_loans +
                                        " (${controller.selectedCurrency.value?.currencyIcon})",
                                    fontsize: 16.sp,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4.r),
                                    child: CustomTextField(
                                      keyboardType: TextInputType.number,
                                      controller:
                                          controller.loanGivenController,
                                      readOnly: isDisabled,
                                      hintText: AppLocalizations.of(context)!
                                              .given_out_in_loans +
                                          " (${controller.selectedCurrency.value?.currencyIcon})",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  CustomText(
                                    text: AppLocalizations.of(context)!
                                            .investment_value +
                                        " (${controller.selectedCurrency.value?.currencyIcon})",
                                    fontsize: 16.sp,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4.r),
                                    child: CustomTextField(
                                      keyboardType: TextInputType.number,
                                      controller:
                                          controller.investmentValueController,
                                      readOnly: isDisabled,
                                      hintText: AppLocalizations.of(context)!
                                              .investment_value +
                                          " (${controller.selectedCurrency.value?.currencyIcon})",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  CustomText(
                                    text: AppLocalizations.of(context)!
                                        .rental_income,
                                    fontsize: 16.sp,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4.r),
                                    child: CustomTextField(
                                      keyboardType: TextInputType.number,
                                      controller:
                                          controller.rentalIncomeController,
                                      readOnly: isDisabled,
                                      hintText: AppLocalizations.of(context)!
                                              .rental_income +
                                          " (${controller.selectedCurrency.value?.currencyIcon})",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  CustomText(
                                    text: AppLocalizations.of(context)!
                                            .immediate_liabilities +
                                        " (${controller.selectedCurrency.value?.currencyIcon})",
                                    fontsize: 16.sp,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4.r),
                                    child: CustomTextField(
                                      keyboardType: TextInputType.number,
                                      controller: controller
                                          .immediateLiabilitieseController,
                                      readOnly: isDisabled,
                                      hintText: AppLocalizations.of(context)!
                                              .immediate_liabilities +
                                          " (${controller.selectedCurrency.value?.currencyIcon})",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    height: 12.h,
                  ),
                  Obx(
                    () => CustomButtonCommon(
                      loading: controller.zakatLoading.value == true,
                      title: AppLocalizations.of(context)!.result,
                      onpress: () {
                        // if (_forRegKey.currentState!.validate()) {

                        if (controller.cashAndBankController.text.isEmpty) {
                          ToastMessageHelper.errorMessageShowToster(
                              AppLocalizations.of(context)!
                                  .at_least_enter_nisab);
                        } else {
                          controller.calculateZakatAmount();
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
