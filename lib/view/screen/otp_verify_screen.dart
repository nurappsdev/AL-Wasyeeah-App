
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';
import '../widgets/widgets.dart';
import 'profile_setting/profile_setting.dart';

class OtpVerifyScreen extends StatelessWidget {
   OtpVerifyScreen({super.key});
  TextEditingController picController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: AppString.oTPVerify.tr,fontsize: 18.sp,),),
      body: Container(
        width: double.infinity,
        height: Get.height,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16.h,),
                Center(child: SvgPicture.asset(AppIcons.otpIcon, height: 270.h, width: double.infinity)),
                SizedBox(height: 16.h,),
                Center(child: CustomText(text: "Enter OTP".tr,fontsize: 24.sp,textAlign: TextAlign.center,fontWeight: FontWeight.w500,)),
                SizedBox(height: 16.h,),
                Center(child: CustomText(text: "An 5 digit code sent to your".tr,fontsize: 16.sp, maxline: 2, textAlign: TextAlign.center,)),
                SizedBox(height: 16.h,),
                CustomPinCodeTextField(textEditingController: picController,),
                SizedBox(height: 16.h,),



                ///=============Sign In Button====================
                CustomButtonCommon(
                  // loading: authController.loadingLoading.value == true,
                  title: "Submit".tr,
                  onpress: () {
                    Get.off(()=>StepNavigationWithPageView());
                    // if (_forRegKey.currentState!.validate()) {
                    //   // authController.loginHandle(
                    //   //     emailController.text, passController.text);
                    // }
                  },),
                SizedBox(height: 14.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(text: "Didn’t receive code?".tr,fontsize: 18.sp,),
                    CustomText(text: "Resent Code".tr,fontsize: 18.sp,color: AppColors.primaryColor,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
