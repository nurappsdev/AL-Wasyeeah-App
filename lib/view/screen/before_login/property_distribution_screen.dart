
import 'package:al_wasyeah/helpers/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class PropertyDistributionScreen extends StatelessWidget {
   PropertyDistributionScreen({super.key});

  TextEditingController samiCNTR = TextEditingController();
  TextEditingController wifeCNTR = TextEditingController();
  TextEditingController sonCNTR = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: "Property Distribution".tr,fontsize: 18.sp,),),
      body: Container(
        width: double.infinity,
        height: Get.height,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomText(text: "List of relatives".tr,fontsize: 18.sp,),
                    ElevatedButton(onPressed: (){
                      Get.toNamed(AppRoutes.loginScreen,preventDuplicates: false);
                    },child:  CustomText(text: "Skip".tr,fontsize: 18.sp,))
            
                  ],
                ),
                SizedBox(height: 12.h,),
                ///First Row========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  samiCNTR,
                          hintText: "Husband".tr,
            
            
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Wife".tr,
            
            
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  sonCNTR,
                          hintText: "Son".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
            
                  ],
                ),
            
                SizedBox(height: 12.h,),
                ///Second Row========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  samiCNTR,
                          hintText: "Dead son".tr,
            
            
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Son of a dead son".tr,
            
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
            
            
                  ],
                ),
            
                SizedBox(height: 12.h,),
                ///third Row========================
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  samiCNTR,
                          hintText: "Daughter of a deceased son".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h,),
                ///Fourth Row========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Daughter".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Dead daughter".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h,),
                ///Fifth Row========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Son of the deceased daughter".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h,),
                ///Six Row========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "The daughter of the deceased daughter".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h,),
                ///Seven Row========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Father".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Mother".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Grandfather".tr,
                          hintextSize: 12.sp,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h,),
                ///Eight Row========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Grandma".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Granny".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Brother".tr,
                          hintextSize: 12.sp,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h,),
                ///Nine Row========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Half-brother (bipartite)".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Half-sister (bilateral)".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h,),
                ///Ten Row========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Stepbrother (half-brother)".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Half-sister (step-sister)".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h,),
                ///ELEVEN Row========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Brother's son".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Son of half-brother (uncle)".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h,),
                ///ELEVEN Row========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Brother's son's son".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 12.h,),
                ///ELEVEN Row========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Son of half-brother's son".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 12.h,),
                ///Eight Row========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Uncle".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Uncle (bilingual)".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Cousin".tr,
                          hintextSize: 12.sp,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12.h,),
                ///Eight Row========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Cousin (bipartite)".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Cousin's son".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),

                  ],
                ),


                SizedBox(height: 12.h,),
                ///Eight Row========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Cousin's son (Baimatreya).".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Cousin's son's son's son".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 12.h,),
                ///Eight Row========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.h),
                        child: CustomTextField(
                          controller:  wifeCNTR,
                          hintText: "Cousin's (Vaimatreya's) son's son".tr,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.secondaryPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
