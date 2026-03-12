import 'package:al_wasyeah/helpers/app_routes.dart';
import 'package:al_wasyeah/view/widgets/background_image_screen_widget.dart';
import 'package:al_wasyeah/view/widgets/custom_button_common.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:al_wasyeah/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';

import 'package:al_wasyeah/l10n/app_localizations.dart';

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
          text: AppLocalizations.of(context)!.property_distribution,
          fontsize: 18.sp,
        ),
      ),
      body: BackgroundImageContainer(
        child: Container(
          width: double.infinity,
          height: Get.height,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
            child: SingleChildScrollView(
              child: Form(
                key: _forProKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomText(
                          text: AppLocalizations.of(context)!.list_of_relatives,
                          fontsize: 18.sp,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.zakatCalculatorScreen,
                                  preventDuplicates: false);
                            },
                            child: CustomText(
                              text: AppLocalizations.of(context)!.skip,
                              fontsize: 18.sp,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    ///First Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: samiCNTR,
                              hintText: AppLocalizations.of(context)!.husband,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!.wife,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: sonCNTR,
                              hintText: AppLocalizations.of(context)!.son,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 12.h,
                    ),

                    ///Second Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: samiCNTR,
                              hintText: AppLocalizations.of(context)!.dead_son,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!
                                  .son_of_a_dead_son,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 12.h,
                    ),

                    ///third Row========================
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: samiCNTR,
                              hintText: AppLocalizations.of(context)!
                                  .daughter_of_a_deceased_son,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    ///Fourth Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!.daughter,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText:
                                  AppLocalizations.of(context)!.dead_daughter,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    ///Fifth Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!
                                  .son_of_the_deceased_daughter,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    ///Six Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!
                                  .the_daughter_of_the_deceased_daughter,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    ///Seven Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!.father,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!.mother,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText:
                                  AppLocalizations.of(context)!.grandfather,
                              hintextSize: 12.sp,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    ///Eight Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!.grandma,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!.granny,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!.brother,
                              hintextSize: 12.sp,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    ///Nine Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!
                                  .half_brother_bipartite,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!
                                  .half_sister_bilateral,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    ///Ten Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!
                                  .stepbrother_half_brother,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!
                                  .half_sister_step_sister,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    ///ELEVEN Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText:
                                  AppLocalizations.of(context)!.brother_s_son,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!
                                  .son_of_half_brother_uncle,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    ///ELEVEN Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!
                                  .brother_s_son_s_son,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    ///ELEVEN Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!
                                  .son_of_half_brother_s_son,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    ///Eight Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!.uncle,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText:
                                  AppLocalizations.of(context)!.uncle_bilingual,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!.cousin,
                              hintextSize: 12.sp,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 12.h,
                    ),

                    ///Eight Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!
                                  .cousin_bipartite,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText:
                                  AppLocalizations.of(context)!.cousin_s_son,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 12.h,
                    ),

                    ///Eight Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!
                                  .cousin_s_son_baimatreya,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!
                                  .cousin_s_son_s_son_s_son,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    ///Eight Row========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: CustomTextField(
                              controller: wifeCNTR,
                              hintText: AppLocalizations.of(context)!
                                  .cousin_s_vaimatreya_s_son_s_son,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.secondaryPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    ///=============Mobile====================
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomText(
                      text: AppLocalizations.of(context)!.asset_description,
                      color: AppColors.hitTextColor000000,
                      fontsize: 20.sp,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomTextField(
                        controller: landCNTR,
                        hintText: AppLocalizations.of(context)!
                            .land_measurement_unit_percentage,
                        borderColor: AppColors.secondaryPrimaryColor,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .land_measurement_unit_percentage;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomTextField(
                        controller: landCNTR,
                        hintText: AppLocalizations.of(context)!
                            .gold_measurement_unit_bhari,
                        borderColor: AppColors.secondaryPrimaryColor,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .gold_measurement_unit_bhari;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomTextField(
                        controller: landCNTR,
                        hintText: AppLocalizations.of(context)!
                            .silver_measurement_unit_bhari,
                        borderColor: AppColors.secondaryPrimaryColor,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .silver_measurement_unit_bhari;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomTextField(
                        controller: landCNTR,
                        hintText: AppLocalizations.of(context)!
                            .money_measurement_unit_taka,
                        borderColor: AppColors.secondaryPrimaryColor,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .money_measurement_unit_taka;
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    ///=============Sign In Button====================
                    CustomButtonCommon(
                      // loading: authController.loadingLoading.value == true,
                      title: AppLocalizations.of(context)!.result,
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
                    //         title: AppLocalizations.of(context)!.reset,
                    //         color: Colors.grey,
                    //         onpress: () {
                    //         //  Get.toNamed(AppRoutes.otpScreen,preventDuplicates: false);
                    //           // if (_forRegKey.currentState!.validate()) {
                    //           //   // authController.loginHandle(
                    //           //   //     emailController.text, passController.text);
                    //           // }
                    //         },),
                    //     ),
                    //     SizedBox(width: 8.w,),
                    //     Expanded(
                    //       child: CustomButtonCommon(
                    //         // loading: authController.loadingLoading.value == true,
                    //         title: AppLocalizations.of(context)!.result,
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
                      height: 12.h,
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
