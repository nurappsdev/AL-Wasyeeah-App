import 'package:al_wasyeah/helpers/app_routes.dart';
import 'package:al_wasyeah/utils/app_dimentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../widgets/widgets.dart';

class PropertyDistributionScreen extends StatelessWidget {
  PropertyDistributionScreen({super.key});
  final GlobalKey<FormState> _forProKey = GlobalKey<FormState>();
  TextEditingController landCNTR = TextEditingController();

  TextEditingController samiCNTR = TextEditingController();
  TextEditingController wifeCNTR = TextEditingController();
  TextEditingController sonCNTR = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Property Distribution".tr,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomText(
                          text: "List of relatives".tr,
                          fontsize: 18,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.zakatCalculatorScreen,
                                  preventDuplicates: false);
                            },
                            child: CustomText(
                              text: "Skip".tr,
                              fontsize: 18,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    ///First Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: samiCNTR,
                              hintText: "Husband".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Wife".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: sonCNTR,
                              hintText: "Son".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 12,
                    ),

                    ///Second Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: samiCNTR,
                              hintText: "Dead son".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Son of a dead son".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 12,
                    ),

                    ///third Row========================
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: samiCNTR,
                              hintText: "Daughter of a deceased son".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    ///Fourth Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Daughter".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Dead daughter".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    ///Fifth Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Son of the deceased daughter".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    ///Six Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText:
                                  "The daughter of the deceased daughter".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    ///Seven Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Father".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Mother".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Grandfather".tr,
                              hintextSize: 12,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    ///Eight Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Grandma".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Granny".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Brother".tr,
                              hintextSize: 12,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    ///Nine Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Half-brother (bipartite)".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Half-sister (bilateral)".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    ///Ten Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Stepbrother (half-brother)".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Half-sister (step-sister)".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    ///ELEVEN Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Brother's son".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Son of half-brother (uncle)".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    ///ELEVEN Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Brother's son's son".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    ///ELEVEN Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Son of half-brother's son".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    ///Eight Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Uncle".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Uncle (bilingual)".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Cousin".tr,
                              hintextSize: 12,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 12,
                    ),

                    ///Eight Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Cousin (bipartite)".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Cousin's son".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 12,
                    ),

                    ///Eight Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Cousin's son (Baimatreya).".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Cousin's son's son's son".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    ///Eight Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: "Cousin's (Vaimatreya's) son's son".tr,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    ///=============Mobile====================
                    SizedBox(
                      height: 16,
                    ),
                    CustomText(
                      text: "Asset Description".tr,
                      color: AppColors.hitTextColor000000,
                      fontsize: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: CustomTextField(
                        controller: landCNTR,
                        hintText: "'Land' Measurement Unit Percentage".tr,
                        borderColor: AppColors.secondaryPrimaryColor,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "'Land' Measurement Unit Percentage".tr;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: CustomTextField(
                        controller: landCNTR,
                        hintText: "'Gold' Measurement Unit Bhari".tr,
                        borderColor: AppColors.secondaryPrimaryColor,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "'Gold' Measurement Unit Bhari".tr;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: CustomTextField(
                        controller: landCNTR,
                        hintText: "'Silver' Measurement Unit Bhari".tr,
                        borderColor: AppColors.secondaryPrimaryColor,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "'Silver' Measurement Unit Bhari".tr;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: CustomTextField(
                        controller: landCNTR,
                        hintText: "'Money' Measurement Unit Taka".tr,
                        borderColor: AppColors.secondaryPrimaryColor,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "'Money' Measurement Unit Taka".tr;
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    ///=============Sign In Button====================
                    CustomButtonCommon(
                      // loading: authController.loadingLoading.value == true,
                      title: "Result".tr,
                      onpress: () {
                        Get.toNamed(AppRoutes.propertyDistributionResultScreen,
                            preventDuplicates: false);
                        // if (_forRegKey.currentState!.validate()) {
                        //   // authController.loginHandle(
                        //   //     emailController.text, passController.text);
                        // }
                      },
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Expanded(
                    //       child: CustomButtonCommon(
                    //         // loading: authController.loadingLoading.value == true,
                    //         title: "Reset".tr,
                    //         color: Colors.grey,
                    //         onpress: () {
                    //         //  Get.toNamed(AppRoutes.otpScreen,preventDuplicates: false);
                    //           // if (_forRegKey.currentState!.validate()) {
                    //           //   // authController.loginHandle(
                    //           //   //     emailController.text, passController.text);
                    //           // }
                    //         },),
                    //     ),
                    //     SizedBox(width: 8,),
                    //     Expanded(
                    //       child: CustomButtonCommon(
                    //         // loading: authController.loadingLoading.value == true,
                    //         title: "Result".tr,
                    //         onpress: () {
                    //           Get.toNamed(AppRoutes.propertyDistributionResultScreen,preventDuplicates: false);
                    //           // if (_forRegKey.currentState!.validate()) {
                    //           //   // authController.loginHandle(
                    //           //   //     emailController.text, passController.text);
                    //           // }
                    //         },),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


