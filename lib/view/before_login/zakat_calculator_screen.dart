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

import '../../controllers/controllers.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';

import 'package:al_wasyeah/l10n/app_localizations.dart';

class ZakatCalculatorScreen extends StatefulWidget {
  ZakatCalculatorScreen({super.key});

  @override
  State<ZakatCalculatorScreen> createState() => _ZakatCalculatorScreenState();
}

class _ZakatCalculatorScreenState extends State<ZakatCalculatorScreen> {
  final GlobalKey<FormState> _forProKey = GlobalKey<FormState>();

  // TextEditingController cashAndBankController = TextEditingController();

  TextEditingController valueGoldController = TextEditingController();

  TextEditingController silverGoldController = TextEditingController();

  TextEditingController futureDepositsController = TextEditingController();

  TextEditingController loanGivenController = TextEditingController();

  TextEditingController investmentValueController = TextEditingController();

  TextEditingController rentalIncomeController = TextEditingController();

  TextEditingController immediateLiabilitieseController = TextEditingController();

  ZakatController zakatController = Get.put(ZakatController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    valueGoldController.dispose();
    silverGoldController.dispose();
    futureDepositsController.dispose();
    loanGivenController.dispose();
    investmentValueController.dispose();
    rentalIncomeController.dispose();
    immediateLiabilitieseController.dispose();
    zakatController.cashAndBankController.dispose();
    // Optional: remove ZakatController from memory if you don't want it reused later
    // Get.delete<ZakatController>();

    super.dispose();
  }

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
        child: Container(
          width: double.infinity,
          height: Get.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
            child: SingleChildScrollView(
              child: Form(
                  key: _forProKey,
                  child: Column(
                    children: [
                      Obx(() {
                        if (zakatController.isNisabLoading.value) {
                          return const CustomLoader();
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.currency} *",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<GetNisabRatesResponseModel>(
                              isExpanded: true,
                              value: zakatController.selectedCurrency.value,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.currency,
                                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                              ),
                              items: zakatController.nisabRates.map((model) {
                                return DropdownMenuItem(
                                  value: model,
                                  child: Text(
                                    "${model.currencyCode} - ${model.currencyIcon}",
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  zakatController.onCurrencySelected(value);
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     CustomText(
                      //       text: AppLocalizations.of(context)!.zakat_calculator,
                      //       fontsize: 18.sp,
                      //     ),
                      //     ElevatedButton(
                      //         onPressed: () {
                      //           Get.toNamed(AppRoutes.loginScreen,
                      //               preventDuplicates: false);
                      //         },
                      //         child: CustomText(
                      //           text: AppLocalizations.of(context)!.skip,
                      //           fontsize: 18.sp,
                      //         ))
                      //   ],
                      // ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Obx(() {
                        final currency = zakatController.selectedCurrency.value;
                        final bool isDisabled = currency == null;

                        String nisabLabel = AppLocalizations.of(context)!.nisab;
                        if (!isDisabled) {
                          final updatedDate = zakatController.nisabRates
                              .where((element) => element.id == currency.id)
                              .first
                              .insertAt;
                          final formattedDate = DateFormat(
                            'yyyy-MM-dd',
                            Get.locale!.languageCode,
                          ).format(updatedDate!);
                          nisabLabel = "${AppLocalizations.of(context)!.nisab} (${AppLocalizations.of(context)!.updated} $formattedDate)";
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
                                border: Border.all(),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 4.h),
                                    CustomText(text: nisabLabel),
                                    Padding(
                                      padding: EdgeInsets.all(4.r),
                                      child: CustomTextField(
                                        readOnly: isDisabled,
                                        controller: zakatController.cashAndBankController,
                                        hintText: AppLocalizations.of(context)!.nisab_amount,
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
                        final bool isDisabled = zakatController.selectedCurrency.value == null;
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
                                padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10.h),
                                      Text(AppLocalizations.of(context)!.value_of_gold),
                                      Padding(
                                        padding: EdgeInsets.all(4.r),
                                        child: CustomTextField(
                                          keyboardType: TextInputType.number,
                                          controller: valueGoldController,
                                          readOnly: isDisabled,
                                          hintText: AppLocalizations.of(context)!.value_of_gold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(AppLocalizations.of(context)!.value_of_silver),
                                      Padding(
                                        padding: EdgeInsets.all(4.r),
                                        child: CustomTextField(
                                          keyboardType: TextInputType.number,
                                          controller: silverGoldController,
                                          readOnly: isDisabled,
                                          hintText: AppLocalizations.of(context)!.value_of_silver,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(AppLocalizations.of(context)!.future_deposits),
                                      Padding(
                                        padding: EdgeInsets.all(4.r),
                                        child: CustomTextField(
                                          keyboardType: TextInputType.number,
                                          controller: futureDepositsController,
                                          readOnly: isDisabled,
                                          hintText: AppLocalizations.of(context)!.future_deposits,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(AppLocalizations.of(context)!.given_out_in_loans),
                                      Padding(
                                        padding: EdgeInsets.all(4.r),
                                        child: CustomTextField(
                                          keyboardType: TextInputType.number,
                                          controller: loanGivenController,
                                          readOnly: isDisabled,
                                          hintText: AppLocalizations.of(context)!.given_out_in_loans,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(AppLocalizations.of(context)!.investment_value),
                                      Padding(
                                        padding: EdgeInsets.all(4.r),
                                        child: CustomTextField(
                                          keyboardType: TextInputType.number,
                                          controller: investmentValueController,
                                          readOnly: isDisabled,
                                          hintText: AppLocalizations.of(context)!.investment_value,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(AppLocalizations.of(context)!.rental_income),
                                      Padding(
                                        padding: EdgeInsets.all(4.r),
                                        child: CustomTextField(
                                          keyboardType: TextInputType.number,
                                          controller: rentalIncomeController,
                                          readOnly: isDisabled,
                                          hintText: AppLocalizations.of(context)!.rental_income,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(AppLocalizations.of(context)!.immediate_liabilities),
                                      Padding(
                                        padding: EdgeInsets.all(4.r),
                                        child: CustomTextField(
                                          keyboardType: TextInputType.number,
                                          controller: immediateLiabilitieseController,
                                          readOnly: isDisabled,
                                          hintText: AppLocalizations.of(context)!.immediate_liabilities,
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
                          loading: zakatController.zakatLoading.value == true,
                          title: AppLocalizations.of(context)!.result,
                          onpress: () {
                            // if (_forRegKey.currentState!.validate()) {

                            if (zakatController.cashAndBankController.text.isEmpty) {
                              ToastMessageHelper.errorMessageShowToster(AppLocalizations.of(context)!.at_least_enter_nisab);
                            } else {
                              zakatController.zakatHandle(
                                  cashAndBank: zakatController.cashAndBankController.text,
                                  goldValue: valueGoldController.text,
                                  futureDeposits: futureDepositsController.text,
                                  immediateLiabilities: immediateLiabilitieseController.text,
                                  investmentValue: investmentValueController.text,
                                  loanGiven: loanGivenController.text,
                                  rentalIncome: rentalIncomeController.text,
                                  silverValue: silverGoldController.text);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
