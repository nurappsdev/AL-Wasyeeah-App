import 'package:al_wasiyyath/app/core/utils/toast_message.dart';
import 'package:al_wasiyyath/app/view/zakat_calculator/controller/zakat_calculator_controller.dart';
import 'package:al_wasiyyath/app/core/widgets/custom_app_bar.dart';
import 'package:al_wasiyyath/app/view/zakat_calculator/model/get_nisab_response_model.dart';
import 'package:al_wasiyyath/app/core/utils/app_colors.dart';
import 'package:al_wasiyyath/app/core/widgets/custom_button_common.dart';
import 'package:al_wasiyyath/app/core/widgets/custom_text.dart';
import 'package:al_wasiyyath/app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:al_wasiyyath/app/core/l10n/app_localizations.dart';

class ZakatCalculatorScreen extends GetView<ZakatCalculatorController> {
  ZakatCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.calculate_your_zakat_easily,
      ),
      body: controller.obx(
        (state) => _buildContent(context, isLoading: false),
        onLoading: _buildContent(context, isLoading: true),
        onError: (err) => ErrorWidget(Exception(err)),
      ),
    );
  }

  Widget _buildContent(BuildContext context, {required bool isLoading}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Skeletonizer(
      enabled: isLoading,
      effect: ShimmerEffect(
        baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
        highlightColor: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
      ),
      containersColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
      child: Container(
        width: double.infinity,
        height: Get.height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Obx(() {
                    if (controller.isNisabLoading.value) {
                      return CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      );
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
                          dropdownColor:
                              isDark ? const Color(0xFF1E1E1E) : Colors.white,
                          iconEnabledColor:
                              isDark ? Colors.white70 : Colors.black54,
                          initialValue: controller.selectedCurrency.value,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor:
                                isDark ? const Color(0xFF25282B) : Colors.white,
                            labelText: AppLocalizations.of(context)!.currency,
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: isDark
                                  ? const Color(0xff94A3B8)
                                  : Colors.black54,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                              borderSide: BorderSide(
                                color: isDark
                                    ? const Color(0xFF2C3E35)
                                    : AppColors.primaryColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                              borderSide: BorderSide(
                                color: AppColors.primaryColor,
                                width: 1.5,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
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
                            color:
                                isDark ? const Color(0xFF1E1E1E) : Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF2C3E35)
                                  : AppColors.primaryColor,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                            color:
                                isDark ? const Color(0xFF1E1E1E) : Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF2C3E35)
                                  : AppColors.primaryColor,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h),
                                  CustomText(
                                    text: AppLocalizations.of(context)!
                                            .value_of_gold +
                                        " (${controller.selectedCurrency.value?.currencyIcon ?? ""})",
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
                                          " (${controller.selectedCurrency.value?.currencyIcon ?? ""})",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  CustomText(
                                    text: AppLocalizations.of(context)!
                                            .value_of_silver +
                                        " (${controller.selectedCurrency.value?.currencyIcon ?? ""})",
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
                                          " (${controller.selectedCurrency.value?.currencyIcon ?? ""})",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  CustomText(
                                    text: AppLocalizations.of(context)!
                                            .future_deposits +
                                        " (${controller.selectedCurrency.value?.currencyIcon ?? ""})",
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
                                          " (${controller.selectedCurrency.value?.currencyIcon ?? ""})",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  CustomText(
                                    text: AppLocalizations.of(context)!
                                            .given_out_in_loans +
                                        " (${controller.selectedCurrency.value?.currencyIcon ?? ""})",
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
                                          " (${controller.selectedCurrency.value?.currencyIcon ?? ""})",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  CustomText(
                                    text: AppLocalizations.of(context)!
                                            .investment_value +
                                        " (${controller.selectedCurrency.value?.currencyIcon ?? ""})",
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
                                          " (${controller.selectedCurrency.value?.currencyIcon ?? ""})",
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
                                          " (${controller.selectedCurrency.value?.currencyIcon ?? ""})",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  CustomText(
                                    text: AppLocalizations.of(context)!
                                            .immediate_liabilities +
                                        " (${controller.selectedCurrency.value?.currencyIcon ?? ""})",
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
                                          " (${controller.selectedCurrency.value?.currencyIcon ?? ""})",
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
                    () => CustomButton(
                      loading: controller.zakatLoading.value == true,
                      title: AppLocalizations.of(context)!.result,
                      onpress: () {
                        // if (_forRegKey.currentState!.validate()) {

                        if (controller.cashAndBankController.text.isEmpty) {
                          ToastMessage.errorMessageShowToster(
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
