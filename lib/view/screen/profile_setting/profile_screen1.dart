import 'dart:developer';
import 'dart:io';

import 'package:al_wasyeah/helpers/file_picker_util.dart';
import 'package:al_wasyeah/main.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/gender_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/marital_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:country_flags/country_flags.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/controllers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
import 'dart:typed_data';

class ProfileSetupStepOneScreen extends StatefulWidget {
  @override
  State<ProfileSetupStepOneScreen> createState() =>
      _ProfileSetupStepOneScreenState();
}

class _ProfileSetupStepOneScreenState extends State<ProfileSetupStepOneScreen> {
  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Only the top-level loading/error depends on status
        if (controller.status.value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (controller.status.value.isError) {
          return const Center(child: Text("Something went wrong"));
        }

        // Main UI
        return Form(
          key: controller.step1formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.h),
            child: RefreshIndicator(
              onRefresh: () => controller.getProfilePageData(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ================= First Name =================
                    const SizedBox(height: 16),
                    CustomText(
                      text: "First Name".tr,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: controller.firstNameController.value,
                      hint: "First Name".tr,
                      validator: (value) =>
                          value!.isEmpty ? "First Name is required" : null,
                    ),

                    SizedBox(height: 16.h),
                    // ================= Last Name =================
                    CustomText(
                      text: "Last Name".tr,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: controller.lastNameController.value,
                      hint: "Last Name".tr,
                      validator: (value) =>
                          value!.isEmpty ? "Last Name is required" : null,
                    ),

                    SizedBox(height: 16.h),
                    // ================= Marital Status =================
                    CustomText(text: "Marital Status".tr, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    Obx(() => CustomDropdown<MaritalModel>(
                          hint: "Select Marital Status",
                          items: controller.maritalList,
                          value: controller.selectedMarried.value,
                          itemToString: (item) => item.maritalType ?? "",
                          onChanged: (val) =>
                              controller.selectedMarried.value = val,
                          validator: (value) => value == null
                              ? "Marital Status is required"
                              : null,
                        )),

                    SizedBox(height: 16.h),
                    // ================= Profession =================
                    CustomText(text: "Profession".tr, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    Obx(() => CustomDropdown<ProfessionModel>(
                          hint: "Select Profession",
                          items: controller.professionList,
                          value: controller.selectedProfession.value,
                          itemToString: (item) => item.profession ?? "",
                          onChanged: (val) =>
                              controller.selectedProfession.value = val,
                        )),

                    SizedBox(height: 16.h),
                    // ================= Place of Birth =================
                    CustomText(text: "Place of Birth".tr, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    Obx(() => CustomDropdown<CountryModel>(
                          hint: "Select Country",
                          items: controller.countryList,
                          value: controller.selectedCountry.value,
                          itemToString: (item) => item.country ?? "",
                          onChanged: (val) =>
                              controller.selectedCountry.value = val,
                        )),

                    SizedBox(height: 16.h),
                    // ================= District/State =================
                    CustomText(text: "District/State".tr, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: controller.districtController.value,
                      hint: "District/State".tr,
                      validator: (value) =>
                          value!.isEmpty ? "District/State is required" : null,
                    ),

                    SizedBox(height: 16.h),
                    // ================= Gender =================
                    CustomText(text: "Gender".tr, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    Obx(() => CustomDropdown<GenderModel>(
                          hint: "Select Gender",
                          items: controller.genderList,
                          value: controller.selectedGender.value,
                          itemToString: (item) => item.gender ?? "",
                          onChanged: (val) =>
                              controller.selectedGender.value = val,
                        )),

                    SizedBox(height: 16.h),
                    // ================= NID / Passport =================
                    CustomText(text: "NID/Passport No".tr, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: controller.nidController.value,
                      hint: "NID/Passport No".tr,
                      validator: (value) =>
                          value!.isEmpty ? "NID/Passport No is required" : null,
                    ),
                    SizedBox(height: 10.h),
                    if (controller
                            .profileModel.value.userProfile?.nidPaperUrl !=
                        null)
                      Obx(() => _buildFileRow(
                            pickedFile: controller.pickedNIDFile,
                            isDownloading: controller.isDownloadingNid,
                            progress: controller.nidDownloadProgress,
                            onPickFile: controller.pickNidFile,
                            onDownload: controller.downloadNidFile,
                            fileUrl: controller
                                .profileModel.value.userProfile?.nidPaperUrl,
                          )),
                    CustomText(
                      text: "* Only Pdf,JPEG,PNG file are allowed".tr,
                      color: AppColors.redColor,
                      fontsize: 12.sp,
                    ),
                    SizedBox(height: 16.h),

                    // ================= TIN =================
                    CustomText(text: "TIN (Tax Identification Number)".tr),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: controller.tinController.value,
                      hint: "TIN".tr,
                      validator: (value) =>
                          value!.isEmpty ? "TIN is required" : null,
                    ),
                    SizedBox(height: 10.h),
                    if (controller
                            .profileModel.value.userProfile?.tinPaperUrl !=
                        null)
                      Obx(() => _buildFileRow(
                            pickedFile: controller.pickedTinFile,
                            isDownloading: controller.isDownloadingTin,
                            progress: controller.tinDownloadProgress,
                            onPickFile: controller.pickTinFile,
                            onDownload: controller.downloadTinFile,
                            fileUrl: controller
                                .profileModel.value.userProfile?.tinPaperUrl,
                          )),
                    CustomText(
                      text: "* Only Pdf,JPEG,PNG file are allowed".tr,
                      color: AppColors.redColor,
                      fontsize: 12.sp,
                    ),
                    SizedBox(height: 16.h),

                    // ================= Multi Citizenship =================
                    CustomText(text: "Multi Citizenship".tr),
                    SizedBox(height: 4.h),
                    Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomDropdown<CountryModel>(
                              hint: "Select Country",
                              items: controller.countryList,
                              value:
                                  controller.selectedMultiCitizenCountry.value,
                              itemToString: (item) => item.country ?? "",
                              onChanged: (val) => controller
                                  .selectedMultiCitizenCountry.value = val,
                            ),
                            SizedBox(height: 10.h),
                            CustomTextFormField(
                              controller: controller
                                  .multiCitizenPassportController.value,
                              hint: "Passport No".tr,
                            ),
                            SizedBox(height: 10.h),
                            if (controller.profileModel.value.userProfile
                                    ?.passportPaperUrl !=
                                null)
                              _buildFileRow(
                                pickedFile: controller.pickedMultiCitizenFile,
                                isDownloading:
                                    controller.isDownloadingMultiCitizen,
                                progress:
                                    controller.multiCitizenDownloadProgress,
                                onPickFile: controller.pickMultiCitizenFile,
                                onDownload: controller.downloadMultiCitizenFile,
                                fileUrl: controller.profileModel.value
                                    .userProfile?.passportPaperUrl,
                              ),
                          ],
                        )),

                    SizedBox(height: 16.h),
                    // ================= Button =================
                    CustomButtonCommon(
                      title: "Next".tr,
                      onpress: () {
                        if (controller.step1formKey.currentState!.validate()) {
                          controller
                              .onStepTapped(controller.currentStep.value + 1);
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  // ---------------- File row helper ----------------
  Widget _buildFileRow({
    required Rxn<PickedFileResult> pickedFile,
    required RxBool isDownloading,
    required RxDouble progress,
    required VoidCallback onPickFile,
    required VoidCallback onDownload,
    String? fileUrl,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.hitTextColor000000,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                side: BorderSide(color: AppColors.primaryColor),
              ),
              onPressed: onPickFile,
              child:
                  Obx(() => Text(pickedFile.value?.fileName ?? "Choose file")),
            ),
          ),
          SizedBox(width: 6.w),
          if (fileUrl != null)
            InkWell(
              onTap: isDownloading.value ? null : onDownload,
              child: Container(
                width: 48.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Obx(() {
                  return isDownloading.value
                      ? Center(
                          child: SizedBox(
                            width: 22.w,
                            height: 22.w,
                            child: CircularProgressIndicator(
                              value: progress.value / 100,
                              strokeWidth: 2,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        )
                      : Icon(Icons.download, color: AppColors.whiteColor);
                }),
              ),
            ),
        ],
      ),
    );
  }
}
