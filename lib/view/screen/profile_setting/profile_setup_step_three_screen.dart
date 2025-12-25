import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/controllers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class ProfileSetupStepThreeScreen extends StatefulWidget {
  ProfileSetupStepThreeScreen({super.key});

  @override
  State<ProfileSetupStepThreeScreen> createState() =>
      _ProfileSetupStepThreeScreenState();
}

class _ProfileSetupStepThreeScreenState
    extends State<ProfileSetupStepThreeScreen> {
  final ProfileController controller = Get.find<ProfileController>();

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
<<<<<<< HEAD
                    ///=============="Father’s Information================================
                    SizedBox(height: 16.h),
                    Center(
                        child: CustomText(
                      text: "Father’s Information".tr,
                      fontsize: 20,
                    )),
                    SizedBox(height: 20.h),
                    CustomText(
                      text: "Father’s Name".tr,
                      color: AppColors.hitTextColor000000,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      controller: controller.fatherNameController.value,
                      hintText: "Father’s Name".tr,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Father’s Name'.tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    // CustomDropdown(label: "Profession".tr,items: profileController.profession,selectedValue: profileController.selectedProfession,),
                    SizedBox(height: 20.h),
                    //  CustomDropdown(label: "Nationality".tr,items: profileController.profession,selectedValue: profileController.selectedProfession,),
                    ///============NID/PASSPORT No*====================
                    SizedBox(height: 20.h),
                    CustomText(
                      text: "NID/Passport No".tr,
                      color: AppColors.hitTextColor000000,
                      fontsize: 16.sp,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller:
                                controller.fatherPassOrNIDController.value,
                            hintText: "NID/Passport No".tr,
                            borderColor: AppColors.secondaryPrimaryColor,
                            onChange: (value) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'NID/Passport No'.tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.attach_file_outlined,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              //  _NIDImageFromGallery();
                              // Add your action here
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
=======
                    // ///=============="Father’s Information================================
                    // SizedBox(height: 16.h),
                    // Center(
                    //     child: CustomText(
                    //   text: "Father’s Information".tr,
                    //   fontsize: 20,
                    // )),
                    // SizedBox(height: 20.h),
                    // CustomText(
                    //   text: "Father’s Name".tr,
                    //   color: AppColors.hitTextColor000000,
                    //   fontsize: 16.sp,
                    // ),
                    // SizedBox(height: 10.h),
                    // CustomTextField(
                    //   controller: fatherController,
                    //   hintText: "Father’s Name".tr,
                    //   borderColor: AppColors.secondaryPrimaryColor,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Father’s Name'.tr;
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // SizedBox(height: 20.h),
                    // // CustomDropdown(label: "Profession".tr,items: profileController.profession,selectedValue: profileController.selectedProfession,),
                    // SizedBox(height: 20.h),
                    // //  CustomDropdown(label: "Nationality".tr,items: profileController.profession,selectedValue: profileController.selectedProfession,),
                    // ///============NID/PASSPORT No*====================
                    // SizedBox(height: 20.h),
                    // CustomText(
                    //   text: "NID/Passport No".tr,
                    //   color: AppColors.hitTextColor000000,
                    //   fontsize: 16.sp,
                    // ),
                    // SizedBox(
                    //   height: 10.h,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Expanded(
                    //       child: CustomTextField(
                    //         controller: passOrNIDController,
                    //         hintText: "NID/Passport No".tr,
                    //         borderColor: AppColors.secondaryPrimaryColor,
                    //         onChange: (value) {},
                    //         validator: (value) {
                    //           if (value == null || value.isEmpty) {
                    //             return 'NID/Passport No'.tr;
                    //           }
                    //           return null;
                    //         },
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 6.w,
                    //     ),
                    //     Container(
                    //       padding: EdgeInsets.symmetric(horizontal: 6.w),
                    //       decoration: BoxDecoration(
                    //         border: Border.all(color: Colors.grey),
                    //         borderRadius: BorderRadius.circular(16.r),
                    //       ),
                    //       child: IconButton(
                    //         icon: Icon(
                    //           Icons.attach_file_outlined,
                    //           color: AppColors.primaryColor,
                    //         ),
                    //         onPressed: () {
                    //           _NIDImageFromGallery();
                    //           // Add your action here
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // if (nIDImages != null)
                    //   Text(
                    //     'Image Path: ${displayImageNIDPath.toString()}',
                    //     style: TextStyle(color: Colors.grey),
                    //   ),
                    // SizedBox(height: 16.h),
>>>>>>> f1c1f0d2fddf63a16db7488b2b88567c8692c7a3
                    // Center(
                    //   child: ToggleButtons(
                    //     isSelected: isSelected,
                    //     onPressed: (index) {
                    //       setState(() {
                    //         // Allow only one button to be selected at a time
                    //         for (int i = 0; i < isSelected.length; i++) {
                    //           isSelected[i] = i == index;
                    //         }
                    //       });
                    //     },
                    //     borderRadius: BorderRadius.circular(8),
                    //     selectedColor: Colors.white,
                    //     fillColor: isSelected[1] ? Colors.red : Colors.green,
                    //     color: Colors.black,
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 50),
                    //         child: Text('Alive'),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 50),
                    //         child: Text('Death'),
                    //       ),
                    //     ],
                    //   ),
                    // ),
<<<<<<< HEAD
                    SizedBox(
                      height: 24.h,
                    ),

                    ///=============="Father’s Information================================
                    SizedBox(height: 20.h),
                    Center(
                        child: CustomText(
                      text: "Mother’s Information".tr,
                      fontsize: 20,
                    )),
                    SizedBox(height: 20.h),
                    CustomText(
                      text: "Mother’s Name".tr,
                      color: AppColors.hitTextColor000000,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      controller: controller.motherNameController.value,
                      hintText: "Mother’s Name".tr,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mother’s Name'.tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    //   CustomDropdown(label: "Profession".tr,items: profileController.profession,selectedValue: profileController.selectedProfession,),
                    SizedBox(height: 20.h),
                    //   CustomDropdown(label: "Nationality".tr,items: profileController.profession,selectedValue: profileController.selectedProfession,),
                    ///============NID/PASSPORT No*====================
                    SizedBox(height: 20.h),
                    CustomText(
                      text: "NID/Passport No".tr,
                      color: AppColors.hitTextColor000000,
                      fontsize: 16.sp,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller:
                                controller.motherPassOrNIDController.value,
                            hintText: "NID/Passport No".tr,
                            borderColor: AppColors.secondaryPrimaryColor,
                            onChange: (value) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'NID/Passport No'.tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.attach_file_outlined,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              // _NIDImageFromGallery();
                              // Add your action here
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6.w,
                    ),

                    SizedBox(height: 16.h),
=======
                    // SizedBox(
                    //   height: 24.h,
                    // ),

                    // ///=============="Father’s Information================================
                    // SizedBox(height: 20.h),
                    // Center(
                    //     child: CustomText(
                    //   text: "Mother’s Information".tr,
                    //   fontsize: 20,
                    // )),
                    // SizedBox(height: 20.h),
                    // CustomText(
                    //   text: "Mother’s Name".tr,
                    //   color: AppColors.hitTextColor000000,
                    //   fontsize: 16.sp,
                    // ),
                    // SizedBox(height: 10.h),
                    // CustomTextField(
                    //   controller: motherNameController,
                    //   hintText: "Mother’s Name".tr,
                    //   borderColor: AppColors.secondaryPrimaryColor,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Mother’s Name'.tr;
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // SizedBox(height: 20.h),
                    // //   CustomDropdown(label: "Profession".tr,items: profileController.profession,selectedValue: profileController.selectedProfession,),
                    // SizedBox(height: 20.h),
                    // //   CustomDropdown(label: "Nationality".tr,items: profileController.profession,selectedValue: profileController.selectedProfession,),
                    // ///============NID/PASSPORT No*====================
                    // SizedBox(height: 20.h),
                    // CustomText(
                    //   text: "NID/Passport No".tr,
                    //   color: AppColors.hitTextColor000000,
                    //   fontsize: 16.sp,
                    // ),
                    // SizedBox(
                    //   height: 10.h,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Expanded(
                    //       child: CustomTextField(
                    //         controller: motherPassOrNIDController,
                    //         hintText: "NID/Passport No".tr,
                    //         borderColor: AppColors.secondaryPrimaryColor,
                    //         onChange: (value) {},
                    //         validator: (value) {
                    //           if (value == null || value.isEmpty) {
                    //             return 'NID/Passport No'.tr;
                    //           }
                    //           return null;
                    //         },
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 6.w,
                    //     ),
                    //     Container(
                    //       padding: EdgeInsets.symmetric(horizontal: 6.w),
                    //       decoration: BoxDecoration(
                    //         border: Border.all(color: Colors.grey),
                    //         borderRadius: BorderRadius.circular(16.r),
                    //       ),
                    //       child: IconButton(
                    //         icon: Icon(
                    //           Icons.attach_file_outlined,
                    //           color: AppColors.primaryColor,
                    //         ),
                    //         onPressed: () {
                    //           _NIDImageFromGallery();
                    //           // Add your action here
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 6.w,
                    // ),
                    // if (nIDImages != null)
                    //   Text(
                    //     'Image Path: ${displayImageNIDPath.toString()}',
                    //     style: TextStyle(color: Colors.grey),
                    //   ),
                    // SizedBox(height: 16.h),
>>>>>>> f1c1f0d2fddf63a16db7488b2b88567c8692c7a3
                    // Center(
                    //   child: ToggleButtons(
                    //     isSelected: isSelected,
                    //     onPressed: (index) {
                    //       setState(() {
                    //         // Allow only one button to be selected at a time
                    //         for (int i = 0; i < isSelected.length; i++) {
                    //           isSelected[i] = i == index;
                    //         }
                    //       });
                    //     },
                    //     borderRadius: BorderRadius.circular(8),
                    //     selectedColor: Colors.white,
                    //     fillColor: isSelected[1] ? Colors.red : Colors.green,
                    //     color: Colors.black,
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 50),
                    //         child: Text('Alive'.tr),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 50),
                    //         child: Text('Death'),
                    //       ),
                    //     ],
                    //   ),
                    // ),
<<<<<<< HEAD
                    SizedBox(height: 16.h),
=======
                    // SizedBox(height: 16.h),
>>>>>>> f1c1f0d2fddf63a16db7488b2b88567c8692c7a3

                    // ///=============Button====================
                    // CustomButtonCommon(
                    //   // loading: authController.loadingLoading.value == true,
                    //   title: "Next".tr,
                    //   onpress: () {
                    //     //    Get.toNamed(AppRoutes.otpScreen,preventDuplicates: false);
                    //     // if (_forRegKey.currentState!.validate()) {
                    //     //   // authController.loginHandle(
                    //     //   //     emailController.text, passController.text);
                    //     // }
                    //   },
                    // ),
                    // SizedBox(height: 16.h),
                  ],
                ),
              ),
            )));
  }
}
