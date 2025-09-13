import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../../helpers/helpers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class BankInfoScreen extends StatefulWidget {
   BankInfoScreen({super.key});

  @override
  State<BankInfoScreen> createState() => _BankInfoScreenState();
}

class _BankInfoScreenState extends State<BankInfoScreen> {
   ProfileController profileController = Get.put(ProfileController());

   TextEditingController accountController = TextEditingController();
   TextEditingController documentsTypeController = TextEditingController();
   TextEditingController noteController = TextEditingController();
   TextEditingController addressController = TextEditingController();

   bool _isContainerVisible = false;

   void _toggleContainer() {
     setState(() {
       _isContainerVisible = !_isContainerVisible;
     });
   }

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
                ///================================= + Add more spouse  =======================================
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: _toggleContainer,
                      child: Text('+ Add more Bank'),
                    ),
                    if (_isContainerVisible)
                      Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Wealth".tr,
                                  style: TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: _toggleContainer,
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),

                            SizedBox(height: 20.h),
                            CustomDropdown(label: "Select Wealth".tr,items: profileController.profession,selectedValue: profileController.selectedProfession,),

                            ///=============Note====================
                            SizedBox(height: 16.h,),
                            CustomText(text: "Note".tr,color: AppColors.hitTextColor000000,fontsize: 16 .sp,),
                            SizedBox(height: 10.h,),
                            Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: CustomTextField(
                                controller:  noteController,
                                hintText: "Note".tr,
                                maxLine: 3,
                                borderColor: AppColors.secondaryPrimaryColor,
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return 'Note'.tr;
                                  }
                                  return null;

                                },
                              ),
                            ),
                            ///=============Note====================
                            SizedBox(height: 16.h,),
                            CustomText(text: "Address".tr,color: AppColors.hitTextColor000000,fontsize: 16 .sp,),
                            SizedBox(height: 10.h,),
                            Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: CustomTextField(
                                controller:  addressController,
                                hintText: "Address".tr,
                                maxLine: 1,
                                borderColor: AppColors.secondaryPrimaryColor,
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return 'Address'.tr;
                                  }
                                  return null;

                                },
                              ),
                            ),


                            ///============NID/PASSPORT No*====================
                            SizedBox(height: 20.h),
                            CustomText(text: "Documents Type".tr,color: AppColors.hitTextColor000000,fontsize: 16.sp,),
                            SizedBox(height: 10.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller:  documentsTypeController,
                                    hintText: "Documents Type".tr,
                                    borderColor: AppColors.secondaryPrimaryColor,
                                    onChange: (value){},
                                    validator: (value){
                                      if(value == null || value.isEmpty){
                                        return 'Documents Type'.tr;
                                      }
                                      return null;

                                    },
                                  ),
                                ),
                                SizedBox(width: 6.w,),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: IconButton(
                                    icon:Icon(Icons.attach_file_outlined,color: AppColors.primaryColor,),
                                    onPressed: () {
                                      // Add your action here
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),

                          ],
                        ),
                      ),
                  ],
                ),

                CustomButtonCommon(
                  // loading: authController.loadingLoading.value == true,
                  title: "Finish".tr,
                  onpress: () {
                        Get.toNamed(AppRoutes.homeScreen,preventDuplicates: false);
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
