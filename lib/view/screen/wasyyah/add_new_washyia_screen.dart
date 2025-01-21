
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
class AddNewWashyiaScreen extends StatelessWidget {
  AddNewWashyiaScreen({super.key});
  TextEditingController noteController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Add more content".tr,
          fontsize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SizedBox(
        height: Get.height,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Note section
                SizedBox(height: 16.h),
                CustomText(
                  text: "add your washiya content title".tr,
                  color: AppColors.hitTextColor000000,
                  fontsize: 16.sp,
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: CustomTextField(
                    controller: addressController,
                    hintText: "add your washiya content title".tr,
                    maxLine: 1,
                    borderColor: AppColors.secondaryPrimaryColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Address'.tr;
                      }
                      return null;
                    },
                  ),
                ),
                // Note section
                SizedBox(height: 16.h),
                CustomText(
                  text: "add your washiya content".tr,
                  color: AppColors.hitTextColor000000,
                  fontsize: 16.sp,
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: CustomTextField(
                    controller: noteController,
                    hintText: "add your washiya content".tr,
                    maxLine: 3,
                    borderColor: AppColors.secondaryPrimaryColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'content'.tr;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 120.h), // Replaces Spacer

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        title: "Cancel".tr,
                        onpress: () {},
                        width: 100.w,
                        height: 40.h,
                        color: Colors.red,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        title: "Save".tr,
                        onpress: () {},
                        width: 100.w,
                        height: 40.h,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
