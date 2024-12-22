import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class BankInfoScreen extends StatelessWidget {
   BankInfoScreen({super.key});
   ProfileController profileController = Get.put(ProfileController());
   TextEditingController accountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///=============="bank’s Information================================
                SizedBox(height: 20.h),
                Center(child: CustomText(text: "Bank Information".tr,fontsize: 20,)),
                SizedBox(height: 20.h),
                CustomDropdown(label: "Bank".tr,items: profileController.banks,selectedValue: profileController.selectedBank,),
                CustomDropdown(label: "Branch".tr,items: profileController.banks,selectedValue: profileController.selectedBank,),
                SizedBox(height: 20.h),
                ///======================Account Name=========================
                CustomText(text: "Account Name".tr,color: AppColors.hitTextColor000000,fontsize: 16 .sp,),
                SizedBox(height: 10.h),
                CustomTextField(
                  controller: accountController,
                  hintText: "Account Name".tr,
                  borderColor: AppColors.secondaryPrimaryColor,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Account Name'.tr;
                    }
                    return null;

                  },
                ),
                SizedBox(height: 16.h),
                ///======================Account Number=========================
                CustomText(text: "Account Number".tr,color: AppColors.hitTextColor000000,fontsize: 16 .sp,),
                SizedBox(height: 10.h),
                CustomTextField(
                  controller: accountController,
                  hintText: "Account Number".tr,
                  borderColor: AppColors.secondaryPrimaryColor,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Account Number '.tr;
                    }
                    return null;

                  },
                ),
                SizedBox(height: 20.h),


                CustomButtonCommon(
                  // loading: authController.loadingLoading.value == true,
                  title: "Submit".tr,
                  onpress: () {
                    //    Get.toNamed(AppRoutes.otpScreen,preventDuplicates: false);
                    // if (_forRegKey.currentState!.validate()) {
                    //   // authController.loginHandle(
                    //   //     emailController.text, passController.text);
                    // }
                  },),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
