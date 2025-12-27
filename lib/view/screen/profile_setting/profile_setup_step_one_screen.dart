import 'dart:developer';

import 'package:al_wasyeah/helpers/file_picker_util.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/gender_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/marital_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../controllers/controllers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

import '../../../controllers/profile/profile_enum.dart';

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

        final form = controller.personalForm.value;
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
                      controller: form.firstName,
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
                      controller: form.lastName,
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
                          value: form.selectedMarried.value,
                          itemToString: (item) => item.maritalType ?? "",
                          onChanged: (val) => form.selectedMarried.value = val,
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
                          value: form.selectedProfession.value,
                          itemToString: (item) => item.profession ?? "",
                          onChanged: (val) =>
                              form.selectedProfession.value = val,
                        )),

                    SizedBox(height: 16.h),
                    // ================= Place of Birth =================
                    CustomText(text: "Place of Birth".tr, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    Obx(() => CustomDropdown<CountryModel>(
                          hint: "Select Country",
                          items: controller.countryList,
                          value: form.selectedCountry.value,
                          itemToString: (item) => item.country ?? "",
                          onChanged: (val) => form.selectedCountry.value = val,
                        )),

                    SizedBox(height: 16.h),
                    // ================= District/State =================
                    CustomText(text: "District/State".tr, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.district,
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
                          value: form.selectedGender.value,
                          itemToString: (item) => item.gender ?? "",
                          onChanged: (val) => form.selectedGender.value = val,
                        )),

                    SizedBox(height: 16.h),
                    // ================= NID / Passport =================
                    CustomText(text: "NID/Passport No".tr, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.nid,
                      hint: "NID/Passport No".tr,
                      validator: (value) =>
                          value!.isEmpty ? "NID/Passport No is required" : null,
                    ),
                    SizedBox(height: 16.h),
                    if (form.nid.text.isNotEmpty)
                      Obx(() {
                        return _buildFileRow(
                          pickedFile: Rxn(controller.pickedFileMap[
                              ProfilePickerType.userNidOrPassport]),
                          isDownloading: (controller.isDownloadingMap[
                                      ProfileDownloadType.userNidOrPassport] ??
                                  false)
                              .obs,
                          progress: (controller.downloadProgressMap[
                                      ProfileDownloadType.userNidOrPassport] ??
                                  0.0)
                              .obs,
                          onPickFile: () => controller
                              .pickFile(ProfilePickerType.userNidOrPassport),
                          onDownload: () async {
                            final isComplete = await controller.downloadFile(
                              urlPath: controller
                                  .profileModel.value.userProfile?.nidPaperUrl,
                              filePrefix: 'NID',
                              type: ProfileDownloadType.userNidOrPassport,
                            );
                            if (isComplete) {
                              Fluttertoast.showToast(
                                msg: "NID File downloaded successfully".tr,
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

                    // ================= TIN =================
                    CustomText(text: "TIN (Tax Identification Number)".tr),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.tin,
                      hint: "TIN".tr,
                      validator: (value) =>
                          value!.isEmpty ? "TIN is required" : null,
                    ),
                    SizedBox(height: 16.h),
                    if (controller
                            .profileModel.value.userProfile?.tinPaperUrl !=
                        null)
                      Obx(() => _buildFileRow(
                            pickedFile: Rxn(controller.pickedFileMap[
                                ProfilePickerType.userTinOrPassport]),
                            isDownloading: (controller.isDownloadingMap[
                                        ProfileDownloadType
                                            .userTinOrPassport] ??
                                    false)
                                .obs,
                            progress: (controller.downloadProgressMap[
                                        ProfileDownloadType
                                            .userTinOrPassport] ??
                                    0.0)
                                .obs,
                            onPickFile: () => controller
                                .pickFile(ProfilePickerType.userTinOrPassport),
                            onDownload: () async {
                              final isComplete = await controller.downloadFile(
                                urlPath: controller.profileModel.value
                                    .userProfile?.tinPaperUrl,
                                filePrefix: 'TIN',
                                type: ProfileDownloadType.userTinOrPassport,
                              );
                              if (isComplete) {
                                Fluttertoast.showToast(
                                  msg: "TIN File downloaded successfully".tr,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: AppColors.primaryColor,
                                  textColor: AppColors.whiteColor,
                                );
                              }
                            },
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
                              value: form.selectedMultiCitizenCountry.value,
                              itemToString: (item) => item.country ?? "",
                              onChanged: (val) =>
                                  form.selectedMultiCitizenCountry.value = val,
                            ),
                            SizedBox(height: 10.h),
                            CustomTextFormField(
                              controller: form.multiCitizenPassport,
                              hint: "Passport No".tr,
                            ),
                            SizedBox(height: 10.h),
                            if (controller.profileModel.value.userProfile
                                    ?.passportPaperUrl !=
                                null)
                              _buildFileRow(
                                pickedFile: Rxn(controller.pickedFileMap[
                                    ProfilePickerType
                                        .userMultiCitizenOrPassport]),
                                isDownloading: (controller.isDownloadingMap[
                                            ProfileDownloadType
                                                .userMultiCitizenOrPassport] ??
                                        false)
                                    .obs,
                                progress: (controller.downloadProgressMap[
                                            ProfileDownloadType
                                                .userMultiCitizenOrPassport] ??
                                        0.0)
                                    .obs,
                                onPickFile: () => controller.pickFile(
                                    ProfilePickerType
                                        .userMultiCitizenOrPassport),
                                onDownload: () async {
                                  final isComplete =
                                      await controller.downloadFile(
                                    urlPath: controller.profileModel.value
                                        .userProfile?.passportPaperUrl,
                                    filePrefix: 'MultiCitizen',
                                    type: ProfileDownloadType
                                        .userMultiCitizenOrPassport,
                                  );
                                  if (isComplete) {
                                    Fluttertoast.showToast(
                                      msg:
                                          "MultiCitizen File downloaded successfully"
                                              .tr,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: AppColors.primaryColor,
                                      textColor: AppColors.whiteColor,
                                    );
                                  }
                                },
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
                foregroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                side: BorderSide(color: AppColors.primaryColor),
              ),
              onPressed: onPickFile,
              child: Obx(
                () => Row(
                  children: [
                    // Icon
                    Icon(
                      Icons.attach_file,
                      size: 20.sp,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(width: 8.w),

                    // Choose file text
                    Text(
                      "Choose file",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),

                    ...[
                      SizedBox(width: 12.w),

                      // Divider
                      Container(
                        height: 18.h,
                        width: 1,
                        color: AppColors.primaryColor.withOpacity(0.4),
                      ),

                      SizedBox(width: 12.w),

                      // File name or placeholder
                      Expanded(
                        child: Text(
                          pickedFile.value?.fileName ?? "No file chosen",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: pickedFile.value == null
                                ? Colors.grey
                                : AppColors.hitTextColor000000,
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
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

// class ProfileSetupStepOneScreen extends StatefulWidget {
//   @override
//   State<ProfileSetupStepOneScreen> createState() =>
//       _ProfileSetupStepOneScreenState();
// }

// class _ProfileSetupStepOneScreenState extends State<ProfileSetupStepOneScreen> {
//   final ProfileController controller = Get.find<ProfileController>();

//   @override
//   Widget build(BuildContext context) {
//     final form = controller.personalForm;

//     return Scaffold(
//       body: Obx(() {
//         if (controller.status.value.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (controller.status.value.isError) {
//           return const Center(child: Text("Something went wrong"));
//         }

//         return Form(
//           key: controller.step1formKey,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 14.h),
//             child: RefreshIndicator(
//               onRefresh: controller.getProfilePageData(),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     /// ---------- First Name ----------
//                     const SizedBox(height: 16),
//                     CustomText(text: "First Name".tr, fontsize: 16.sp),
//                     SizedBox(height: 4.h),
//                     CustomTextFormField(
//                       controller: form.value.firstName,
//                       hint: "First Name".tr,
//                       validator: (v) =>
//                           v!.isEmpty ? "First Name is required" : null,
//                     ),

//                     /// ---------- Last Name ----------
//                     SizedBox(height: 16.h),
//                     CustomText(text: "Last Name".tr, fontsize: 16.sp),
//                     SizedBox(height: 4.h),
//                     CustomTextFormField(
//                       controller: form.value.lastName,
//                       hint: "Last Name".tr,
//                       validator: (v) =>
//                           v!.isEmpty ? "Last Name is required" : null,
//                     ),

//                     /// ---------- Marital Status ----------
//                     SizedBox(height: 16.h),
//                     CustomText(text: "Marital Status".tr, fontsize: 16.sp),
//                     SizedBox(height: 4.h),
//                     Obx(() => CustomDropdown<MaritalModel>(
//                           hint: "Select Marital Status",
//                           items: controller.maritalList,
//                           value: form.value.selectedMarried.value,
//                           itemToString: (e) => e.maritalType ?? '',
//                           onChanged: (v) =>
//                               form.value.selectedMarried.value = v,
//                           validator: (v) =>
//                               v == null ? "Marital Status is required" : null,
//                         )),

//                     /// ---------- Profession ----------
//                     SizedBox(height: 16.h),
//                     CustomText(text: "Profession".tr, fontsize: 16.sp),
//                     SizedBox(height: 4.h),
//                     Obx(() => CustomDropdown<ProfessionModel>(
//                           hint: "Select Profession",
//                           items: controller.professionList,
//                           value: form.value.selectedProfession.value,
//                           itemToString: (e) => e.profession ?? '',
//                           onChanged: (v) =>
//                               form.value.selectedProfession.value = v,
//                         )),

//                     /// ---------- Place of Birth ----------
//                     SizedBox(height: 16.h),
//                     CustomText(text: "Place of Birth".tr, fontsize: 16.sp),
//                     SizedBox(height: 4.h),
//                     Obx(() => CustomDropdown<CountryModel>(
//                           hint: "Select Country",
//                           items: controller.countryList,
//                           value: form.value.selectedCountry.value,
//                           itemToString: (e) => e.country ?? '',
//                           onChanged: (v) =>
//                               form.value.selectedCountry.value = v,
//                         )),

//                     /// ---------- District ----------
//                     SizedBox(height: 16.h),
//                     CustomText(text: "District/State".tr, fontsize: 16.sp),
//                     SizedBox(height: 4.h),
//                     CustomTextFormField(
//                       controller: form.value.district,
//                       hint: "District/State".tr,
//                       validator: (v) =>
//                           v!.isEmpty ? "District/State is required" : null,
//                     ),

//                     /// ---------- Gender ----------
//                     SizedBox(height: 16.h),
//                     CustomText(text: "Gender".tr, fontsize: 16.sp),
//                     SizedBox(height: 4.h),
//                     Obx(() => CustomDropdown<GenderModel>(
//                           hint: "Select Gender",
//                           items: controller.genderList,
//                           value: form.value.selectedGender.value,
//                           itemToString: (e) => e.gender ?? '',
//                           onChanged: (v) => form.value.selectedGender.value = v,
//                         )),

//                     /// ---------- NID ----------
//                     SizedBox(height: 16.h),
//                     CustomText(text: "NID/Passport No".tr, fontsize: 16.sp),
//                     SizedBox(height: 4.h),
//                     CustomTextFormField(
//                       controller: form.value.nid,
//                       hint: "NID/Passport No".tr,
//                       validator: (v) =>
//                           v!.isEmpty ? "NID/Passport No is required" : null,
//                     ),

//                     /// ---------- TIN ----------
//                     SizedBox(height: 16.h),
//                     CustomText(text: "TIN".tr),
//                     SizedBox(height: 4.h),
//                     CustomTextFormField(
//                       controller: form.value.tin,
//                       hint: "TIN".tr,
//                       validator: (v) => v!.isEmpty ? "TIN is required" : null,
//                     ),

//                     /// ---------- Multi Citizenship ----------
//                     SizedBox(height: 16.h),
//                     CustomText(text: "Multi Citizenship".tr),
//                     SizedBox(height: 4.h),
//                     Obx(() => CustomDropdown<CountryModel>(
//                           hint: "Select Country",
//                           items: controller.countryList,
//                           value: form.value.selectedMultiCitizenCountry.value,
//                           itemToString: (e) => e.country ?? '',
//                           onChanged: (v) =>
//                               form.value.selectedMultiCitizenCountry.value = v,
//                         )),
//                     SizedBox(height: 10.h),
//                     CustomTextFormField(
//                       controller: form.value.multiCitizenPassport,
//                       hint: "Passport No".tr,
//                     ),

//                     /// ---------- Next Button ----------
//                     SizedBox(height: 20.h),
//                     CustomButtonCommon(
//                       title: "Next".tr,
//                       onpress: () {
//                         if (controller.step1formKey.currentState!.validate()) {
//                           controller
//                               .onStepTapped(controller.currentStep.value + 1);
//                         }
//                       },
//                     ),
//                     SizedBox(height: 30.h),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
