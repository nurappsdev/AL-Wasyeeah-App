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

import '../../../controllers/profile/profile_enum.dart';

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
                            .profileModel.value.parentInfo?.fatherNidUrl !=
                        null)
                      Obx(() {
                        return FileChooseAndDownloadButton(
                          pickedFile: Rxn(controller
                              .pickedFileMap[ProfilePickerType.fatherNid]),
                          isDownloading: (controller.isDownloadingMap[
                                      ProfileDownloadType.fatherNid] ??
                                  false)
                              .obs,
                          progress: (controller.downloadProgressMap[
                                      ProfileDownloadType.fatherNid] ??
                                  0.0)
                              .obs,
                          onPickFile: () =>
                              controller.pickFile(ProfilePickerType.fatherNid),
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
                              .profileModel.value.parentInfo?.fatherNidUrl,
                        );
                      }),
                    CustomText(
                      text: "* Only Pdf,JPEG,PNG file are allowed".tr,
                      color: AppColors.redColor,
                      fontsize: 12.sp,
                    ),
                    SizedBox(height: 16.h),
                    AliveDeadToggle(isAlive: controller.isFatherAlive),

                    ///=============="Mother's Information================================
                    SizedBox(height: 16.h),
                    CustomText(
                      text: "Mother's Name".tr,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: controller.motherNameController.value,
                      hint: "Mother's Name".tr,
                      validator: (value) =>
                          value!.isEmpty ? "Mother's Name is required" : null,
                    ),
                    SizedBox(height: 16.h),
                    //================== Mother Profession ====================
                    CustomText(
                      text: "Mother's Profession".tr,
                      fontsize: 16.sp,
                    ),

                    SizedBox(height: 4.h),
                    CustomDropdown<ProfessionModel>(
                      hint: "Profession".tr,
                      items: controller.professionList,
                      value: controller.selectedMotherProfession.value,
                      itemToString: (item) => item.profession ?? "",
                      onChanged: (val) =>
                          controller.selectedMotherProfession.value = val,
                    ),
                    SizedBox(height: 16.h),

                    ///============Mother NID/PASSPORT No*====================

                    CustomText(
                        text: "Mother's NID/Passport No".tr, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: controller.motherPassOrNIDController.value,
                      hint: "NID/Passport No".tr,
                      validator: (value) => value!.isEmpty
                          ? "Mother's NID/Passport No is required"
                          : null,
                    ),
                    SizedBox(height: 16.h),
                    if (controller
                            .profileModel.value.parentInfo?.motherNidUrl !=
                        null)
                      Obx(() {
                        return FileChooseAndDownloadButton(
                          pickedFile: Rxn(controller
                              .pickedFileMap[ProfilePickerType.motherNid]),
                          isDownloading: (controller.isDownloadingMap[
                                      ProfileDownloadType.motherNid] ??
                                  false)
                              .obs,
                          progress: (controller.downloadProgressMap[
                                      ProfileDownloadType.motherNid] ??
                                  0.0)
                              .obs,
                          onPickFile: () =>
                              controller.pickFile(ProfilePickerType.motherNid),
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
                              .profileModel.value.parentInfo?.motherNidUrl,
                        );
                      }),
                    CustomText(
                      text: "* Only Pdf,JPEG,PNG file are allowed".tr,
                      color: AppColors.redColor,
                      fontsize: 12.sp,
                    ),
                    SizedBox(height: 16.h),
                    AliveDeadToggle(isAlive: controller.isMotherAlive),
                  ],
                ),
              ),
            )));
  }
}

class AliveDeadToggle extends StatelessWidget {
  final RxBool isAlive;
  AliveDeadToggle({required this.isAlive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: Obx(() => Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => isAlive(true),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isAlive.value ? Colors.green : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isAlive.value ? Colors.green : Colors.grey,
                      ),
                    ),
                    child: Text(
                      'Alive',
                      style: TextStyle(
                        color: isAlive.value ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: InkWell(
                  onTap: () => isAlive(false),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: !isAlive.value ? Colors.green : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: !isAlive.value ? Colors.green : Colors.grey,
                      ),
                    ),
                    child: Text(
                      'Dead',
                      style: TextStyle(
                        color: !isAlive.value ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
