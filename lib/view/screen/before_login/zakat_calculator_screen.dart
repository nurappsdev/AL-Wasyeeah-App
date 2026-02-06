import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/controllers.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../helpers/helpers.dart';
import '../../../models/models.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_dimentions.dart';
import '../../widgets/widgets.dart';

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

  TextEditingController immediateLiabilitieseController =
      TextEditingController();

  ZakatController zakatController = Get.find<ZakatController>();

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
    zakatController.getNisabRates();
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Calculate Your Zakat Easily".tr,
          fontsize: 18,
        ),
      ),
      body: BackgroundImageContainer(
        child: Container(
          width: double.infinity,
          height: Get.height,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge),
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
                            const Text(
                              "Currency *",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<GetNisabRatesResponseModel>(
                              isExpanded: true,
                              value: zakatController.selectedCurrency.value,
                              decoration: InputDecoration(
                                labelText: "Currency",
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 16),
                              ),
                              items: zakatController.nisabRates.map((model) {
                                return DropdownMenuItem(
                                  value: model,
                                  child: Text(
                                    "${model.currencyCode} ${model.currencyIcon}",
                                    style: GoogleFonts.notoSans(),
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
                        height: 12,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     CustomText(
                      //       text: "Zakat Calculator".tr,
                      //       fontsize: 18,
                      //     ),
                      //     ElevatedButton(
                      //         onPressed: () {
                      //           Get.toNamed(AppRoutes.loginScreen,
                      //               preventDuplicates: false);
                      //         },
                      //         child: CustomText(
                      //           text: "Skip".tr,
                      //           fontsize: 18,
                      //         ))
                      //   ],
                      // ),
                      SizedBox(
                        height: 12,
                      ),
                      Obx(() {
                        final currency = zakatController.selectedCurrency.value;
                        final updatedDate =
                            DateFormat('dd/MM/yyyy').format(DateTime.now());

                        return Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.radiusExtraLarge),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4),
                                CustomText(
                                    text: "Nisab (updated $updatedDate)"),
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: CustomTextField(
                                    readOnly: false,
                                    controller:
                                        zakatController.cashAndBankController,
                                    // controller: TextEditingController(
                                    //   text: "${currency?.nisabAmount?.toStringAsFixed(0) ?? ''} ${currency?.currencyIcon ?? ''}",
                                    // ),
                                    hintText: "Nisab amount",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 450,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.primaryColor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.radiusExtraLarge),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                CustomText(
                                  text: "Value of Gold".tr,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: CustomTextField(
                                    keyboardType: TextInputType.number,
                                    controller: valueGoldController,
                                    hintText: "Value of Gold".tr,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomText(
                                  text: "Value of Silver".tr,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: CustomTextField(
                                    keyboardType: TextInputType.number,
                                    controller: silverGoldController,
                                    hintText: "Value of Silver".tr,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomText(
                                  text: "Future deposits".tr,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: CustomTextField(
                                    keyboardType: TextInputType.number,
                                    controller: futureDepositsController,
                                    hintText: "Future deposits".tr,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomText(
                                  text: "Given out in loans".tr,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: CustomTextField(
                                    keyboardType: TextInputType.number,
                                    controller: loanGivenController,
                                    hintText: "Given out in loans".tr,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomText(
                                  text: "Investment value".tr,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: CustomTextField(
                                    keyboardType: TextInputType.number,
                                    controller: investmentValueController,
                                    hintText: "Investment value".tr,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomText(
                                  text: "Rental income".tr,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: CustomTextField(
                                    keyboardType: TextInputType.number,
                                    controller: rentalIncomeController,
                                    hintText: "Rental income".tr,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomText(
                                  text: "Immediate liabilities".tr,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: CustomTextField(
                                    keyboardType: TextInputType.number,
                                    controller: immediateLiabilitieseController,
                                    hintText: "Immediate liabilities".tr,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => CustomButtonCommon(
                          loading: zakatController.zakatLoading.value == true,
                          title: "Result".tr,
                          onpress: () {
                            // if (_forRegKey.currentState!.validate()) {

                            if (zakatController
                                .cashAndBankController.text.isEmpty) {
                              ToastMessageHelper.errorMessageShowToster(
                                  "At least Enter Nisab");
                            } else {
                              zakatController.zakatHandle(
                                  cashAndBank: zakatController
                                      .cashAndBankController.text,
                                  goldValue: valueGoldController.text,
                                  futureDeposits: futureDepositsController.text,
                                  immediateLiabilities:
                                      immediateLiabilitieseController.text,
                                  investmentValue:
                                      investmentValueController.text,
                                  loanGiven: loanGivenController.text,
                                  rentalIncome: rentalIncomeController.text,
                                  silverValue: silverGoldController.text);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context,
      {required String assetsAccount, required String zakatAccount}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomText(
            text: "Result".tr,
            fontsize: 20,
            fontWeight: FontWeight.w600,
          ),
          content: Container(
            width: double.infinity,
            height: 200,
            child: Column(
              children: [
                Divider(),
                CustomText(
                  text: "Total Assets".tr,
                  fontsize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
                SizedBox(
                  height: 12,
                ),
                CustomText(
                  text: assetsAccount,
                  fontsize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
                Divider(
                  color: AppColors.primaryColor,
                ),
                CustomText(
                  text: "PAYABLE ZAKAT".tr,
                  fontsize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
                SizedBox(
                  height: 12,
                ),
                CustomText(
                  text: zakatAccount,
                  fontsize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ),
          // actions: <Widget>[
          //   TextButton(
          //     child: CustomText(text:  "Result".tr,),
          //     onPressed: () {
          //       Navigator.of(context).pop(); // Close the dialog
          //     },
          //   ),
          // ],
        );
      },
    );
  }
}
