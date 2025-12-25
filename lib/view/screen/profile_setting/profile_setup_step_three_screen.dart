import 'dart:io';

import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/view/widgets/file_choose_and_download_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
                    ///=============="Father’s Information================================
                    SizedBox(height: 16.h),
                    CustomText(
                      text: "Father's Name".tr,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: controller.fatherNameController.value,
                      hint: "Father's Name".tr,
                      validator: (value) =>
                          value!.isEmpty ? "Father's Name is required" : null,
                    ),
                    SizedBox(height: 16.h),
                    //================== Father Profession ====================
                    CustomText(
                      text: "Father's Profession".tr,
                      fontsize: 16.sp,
                    ),

                    SizedBox(height: 4.h),
                    CustomDropdown<ProfessionModel>(
                      hint: "Profession".tr,
                      items: controller.professionList,
                      value: controller.selectedFatherProfession.value,
                      itemToString: (item) => item.profession ?? "",
                      onChanged: (val) =>
                          controller.selectedFatherProfession.value = val,
                    ),
                    SizedBox(height: 16.h),

                    ///============Father NID/PASSPORT No*====================

                    CustomText(
                        text: "Father's NID/Passport No".tr, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: controller.fatherPassOrNIDController.value,
                      hint: "NID/Passport No".tr,
                      validator: (value) => value!.isEmpty
                          ? "Father's NID/Passport No is required"
                          : null,
                    ),
                    SizedBox(height: 16.h),
                    if (controller
                            .profileModel.value.userProfile?.nidPaperUrl !=
                        null)
                      Obx(() {
                        return FileChooseAndDownloadButton(
                          pickedFile: controller.pickedNIDFile,
                          isDownloading: controller.isDownloadingNid,
                          progress: controller.nidDownloadProgress,
                          onPickFile: controller.pickNidFile,
                          onDownload: () async {
                            final isComplete =
                                await controller.downloadNidFile();
                            if (isComplete) {
                              Fluttertoast.showToast(
                                msg: "NID/Passport File downloaded successfully"
                                    .tr,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 2,
                                backgroundColor: AppColors.primaryColor,
                                textColor: AppColors.whiteColor,
                              );
                            }
                          },
                          fileUrl: controller
                              .profileModel.value.userProfile?.nidPaperUrl,
                        );
                      }),
                    CustomText(
                      text: "* Only Pdf,JPEG,PNG file are allowed".tr,
                      color: AppColors.redColor,
                      fontsize: 12.sp,
                    ),
                    SizedBox(height: 16.h),

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
                    SizedBox(height: 16.h),

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
