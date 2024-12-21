import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class PresentAddressScreen extends StatefulWidget {
   PresentAddressScreen({super.key});

  @override
  State<PresentAddressScreen> createState() => _PresentAddressScreenState();
}

class _PresentAddressScreenState extends State<PresentAddressScreen> {
TextEditingController zipCodeController = TextEditingController();
TextEditingController villageController = TextEditingController();
TextEditingController roadController = TextEditingController();
TextEditingController permanentZipCodeController = TextEditingController();
TextEditingController permanentVillageController = TextEditingController();
TextEditingController permanentRoadController = TextEditingController();
TextEditingController mobileController = TextEditingController();

   ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: double.infinity,
        child: Padding(
          padding:EdgeInsets.symmetric(horizontal: 14.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h,),

                ///=============ZIP Code====================
                SizedBox(height: 16.h,),
                CustomText(text: "ZIP Code".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                SizedBox(height: 10.h,),
                CustomTextField(
                  controller: zipCodeController,
                  hintText: "ZIP Code".tr,
                  borderColor: AppColors.secondaryPrimaryColor,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'ZIP Code'.tr;
                    }
                    return null;

                  },
                ),
                SizedBox(height: 16.h),
                ///=============Village/House====================

                CustomText(text: "Village/House".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                SizedBox(height: 10.h,),
                CustomTextField(
                  controller: villageController,
                  hintText: "Village/House".tr,
                  borderColor: AppColors.secondaryPrimaryColor,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Village/House'.tr;
                    }
                    return null;

                  },
                ),
                SizedBox(height: 16.h),
                ///=============Road/Block/Sector====================
                CustomText(text: "Road/Block/Sector".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                SizedBox(height: 10.h,),
                CustomTextField(
                  controller: roadController,
                  hintText: "Road/Block/Sector".tr,
                  borderColor: AppColors.secondaryPrimaryColor,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Road/Block/Sector'.tr;
                    }
                    return null;

                  },
                ),
                SizedBox(height: 20.h),

                Center(child: CustomText(text: "Permanent Address".tr,fontsize: 20,)),
                SizedBox(height: 20.h,),
                ///=============ZIP Code====================

                CustomText(text: "ZIP Code".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                SizedBox(height: 10.h,),
                CustomTextField(
                  controller: permanentZipCodeController,
                  hintText: "ZIP Code".tr,
                  borderColor: AppColors.secondaryPrimaryColor,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'ZIP Code'.tr;
                    }
                    return null;

                  },
                ),
                SizedBox(height: 16.h),
                ///=============Village/House====================

                CustomText(text: "Village/House".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                SizedBox(height: 10.h,),
                CustomTextField(
                  controller: permanentVillageController,
                  hintText: "Village/House".tr,
                  borderColor: AppColors.secondaryPrimaryColor,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Village/House'.tr;
                    }
                    return null;

                  },
                ),
                SizedBox(height: 16.h),
                ///=============Road/Block/Sector====================
                CustomText(text: "Road/Block/Sector".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                SizedBox(height: 10.h,),
                CustomTextField(
                  controller: permanentRoadController,
                  hintText: "Road/Block/Sector".tr,
                  borderColor: AppColors.secondaryPrimaryColor,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Road/Block/Sector'.tr;
                    }
                    return null;

                  },
                ),
                SizedBox(height: 20.h),
                Center(child: CustomText(text: "Overseas Address".tr,fontsize: 20,)),
                SizedBox(height: 20.h,),

                ///=============Road/Block/Sector====================
                CustomText(text: "Mobile".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                SizedBox(height: 10.h,),
                CustomTextField(
                  controller: mobileController,
                  hintText: "Mobile".tr,
                  borderColor: AppColors.secondaryPrimaryColor,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Mobile'.tr;
                    }
                    return null;

                  },
                ),
                SizedBox(height: 20.h),


                Center(
                  child: Container(
                    height: 50.h, // Adjust the height here
                    width: 250.w, // Full width
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r), // Rounded corners
                      border: Border.all(color: Colors.grey), // Border styling
                      color: Colors.white, // Background color
                    ),
                    child: DropdownButton<String>(

                      value: profileController.selectedCountry,
                      onChanged: (String? newValue) {
                        setState(() {
                          profileController.selectedCountry = newValue!;
                        });
                      },
                      underline: SizedBox.shrink(), // Remove the default underline
                      items:profileController.muslimCountriesInWorld.map<DropdownMenuItem<String>>((country) {
                        return DropdownMenuItem<String>(
                          value: country['name'],
                          child: SingleChildScrollView( // Make the content scrollable if needed
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,  // Ensure it only takes up needed space
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Properly space elements
                              crossAxisAlignment: CrossAxisAlignment.center,  // Align items centrally
                              children: [
                                // Country name
                                Text(
                                  country['name']!,
                                  overflow: TextOverflow.ellipsis,  // Prevent overflow of text
                                ),
                                SizedBox(width: 10.w),  // Space between text and flag
                                // Country flag
                                CountryFlag.fromCountryCode(
                                  country['flag']!,
                                  width: 24.w,  // Adjust the width of the flag
                                  height: 24.h, // Adjust the height of the flag
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                ///=============Button====================
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
                SizedBox(height: 20.h,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
