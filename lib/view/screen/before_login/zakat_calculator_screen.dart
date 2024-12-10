import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helpers/helpers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class ZakatCalculatorScreen extends StatelessWidget {
   ZakatCalculatorScreen({super.key});
  final GlobalKey<FormState> _forProKey = GlobalKey<FormState>();
  TextEditingController nisabController = TextEditingController();
  TextEditingController valueGoldController = TextEditingController();
  TextEditingController silverGoldController = TextEditingController();
  TextEditingController futureGoldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: "Calculate Your Zakat Easily".tr,fontsize: 18.sp,),),
    body: BackgroundImageContainer(
    child: Container(
    width: double.infinity,
      height: Get.height,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
        child: SingleChildScrollView(
          child: Form(
            key: _forProKey,
            child: Column(
              children: [
                 SizedBox(height: 12.h,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomText(text: "Zakat Calculator".tr,fontsize: 18.sp,),
                ElevatedButton(onPressed: (){
                  Get.toNamed(AppRoutes.loginScreen,preventDuplicates: false);
                },child:  CustomText(text: "Skip".tr,fontsize: 18.sp,))

              ],
            ),
                SizedBox(height: 12.h,),
                Container(
                  height: 100.h,
                  width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(),),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4.h,),
                        CustomText(text: "Nisab(updated 07/03/2024)",),
                        Padding(
                          padding:  EdgeInsets.all(4.r),
                          child: CustomTextField(
                            controller: nisabController,
                          hintText: "57,000 ৳",

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                Container(
                  height: 450.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.primaryColor),),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        CustomText(text: "Value of Gold".tr,),
                        Padding(
                          padding:  EdgeInsets.all(4.r),
                          child: CustomTextField(
                            controller: valueGoldController,
                            hintText: "Value of Gold".tr,

                          ),
                        ),
                        SizedBox(height: 20.h,),
                        CustomText(text: "Value of Silver".tr,),
                        Padding(
                          padding:  EdgeInsets.all(4.r),
                          child: CustomTextField(
                            controller: silverGoldController,
                            hintText: "Value of Silver".tr,

                          ),
                        ),
                        SizedBox(height: 20.h,),
                        CustomText(text: "Cash In hand and in bank accounts".tr,),
                        Padding(
                          padding:  EdgeInsets.all(4.r),
                          child: CustomTextField(
                            controller: silverGoldController,
                            hintText: "Cash In hand and in bank accounts".tr,

                          ),
                        ),
                        SizedBox(height: 20.h,),
                        CustomText(text: "Given out in loans".tr,),
                        Padding(
                          padding:  EdgeInsets.all(4.r),
                          child: CustomTextField(
                            controller: futureGoldController,
                            hintText: "Given out in loans".tr,

                          ),
                        ),
                      ],
                    ),
                  ),

                ),
                SizedBox(height: 12.h,),
                CustomButtonCommon(
                  // loading: authController.loadingLoading.value == true,
                  title: "Result".tr,
                  onpress: () {
                    Get.toNamed(AppRoutes.propertyDistributionResultScreen,preventDuplicates: false);
                    // if (_forRegKey.currentState!.validate()) {
                    //   // authController.loginHandle(
                    //   //     emailController.text, passController.text);
                    // }
                  },),
                SizedBox(height: 10.h),
              ],
            )
          ),
        ),
      ),
    ),
    ),
    );

  }
}
