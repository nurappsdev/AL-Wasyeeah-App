import 'package:al_wasyeah/helpers/file_picker_util.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/gender_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/marital_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/view/widgets/custom_button_common.dart';
import 'package:al_wasyeah/view/widgets/custom_dropdown.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:al_wasyeah/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../controllers/controllers.dart';

import 'package:al_wasyeah/l10n/app_localizations.dart';

class ProfileSettingStepOneWidget extends StatefulWidget {
  @override
  State<ProfileSettingStepOneWidget> createState() => _ProfileSettingStepOneWidgetState();
}

class _ProfileSettingStepOneWidgetState extends State<ProfileSettingStepOneWidget> {
  final ProfileController controller = Get.find<ProfileController>();
  Widget _sectionTitle(String title) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Container(
          height: 48.h,
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.all(8.h),
          child: Text(
            title.tr,
            style: TextStyle(color: Colors.white, fontSize: 22.sp),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Only the top-level loading/error depends on status
      if (controller.status.value.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (controller.status.value.isError) {
        return Center(child: Text(AppLocalizations.of(context)!.something_went_wrong));
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
                  _sectionTitle(AppLocalizations.of(context)!.personal_information),
                  // ================= First Name =================
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CustomText(text: AppLocalizations.of(context)!.first_name, fontsize: 16.sp),
                      Text(' *', style: TextStyle(color: Colors.red, fontSize: 16.sp)),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  CustomTextFormField(
                    controller: form.firstName,
                    hint: AppLocalizations.of(context)!.first_name,
                    validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.first_name_is_required : null,
                  ),

                  SizedBox(height: 16.h),
                  // ================= Last Name =================
                  Row(
                    children: [
                      CustomText(text: AppLocalizations.of(context)!.last_name, fontsize: 16.sp),
                      Text(' *', style: TextStyle(color: Colors.red, fontSize: 16.sp)),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  CustomTextFormField(
                    controller: form.lastName,
                    hint: AppLocalizations.of(context)!.last_name,
                    validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.last_name_is_required : null,
                  ),

                  SizedBox(height: 16.h),
                  // ================= Marital Status =================
                  Row(
                    children: [
                      CustomText(text: AppLocalizations.of(context)!.marital_status, fontsize: 16.sp),
                      Text(' *', style: TextStyle(color: Colors.red, fontSize: 16.sp)),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Obx(() => CustomDropdown<MaritalModel>(
                        hint: AppLocalizations.of(context)!.select_marital_status,
                        items: controller.maritalList,
                        value: form.selectedMarried.value,
                        itemToString: (item) => item.maritalType ?? "",
                        onChanged: (val) => form.selectedMarried.value = val,
                        validator: (value) => value == null ? AppLocalizations.of(context)!.marital_status_is_required : null,
                      )),

                  SizedBox(height: 16.h),
                  // ================= Profession =================
                  CustomText(text: AppLocalizations.of(context)!.profession, fontsize: 16.sp),
                  SizedBox(height: 4.h),
                  Obx(() => CustomDropdown<ProfessionModel>(
                        hint: AppLocalizations.of(context)!.select_profession,
                        items: controller.professionList,
                        value: form.selectedProfession.value,
                        itemToString: (item) => item.profession ?? "",
                        onChanged: (val) => form.selectedProfession.value = val,
                      )),

                  SizedBox(height: 16.h),
                  // ================= Place of Birth =================
                  Row(
                    children: [
                      CustomText(text: AppLocalizations.of(context)!.place_of_birth, fontsize: 16.sp),
                      Text(' *', style: TextStyle(color: Colors.red, fontSize: 16.sp)),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Obx(() => CustomDropdown<CountryModel>(
                        hint: AppLocalizations.of(context)!.select_country,
                        items: controller.countryList,
                        value: form.selectedCountry.value,
                        itemToString: (item) => item.country ?? "",
                        onChanged: (val) => form.selectedCountry.value = val,
                      )),

                  SizedBox(height: 16.h),
                  // ================= District/State =================
                  CustomText(text: AppLocalizations.of(context)!.district_state, fontsize: 16.sp),
                  SizedBox(height: 4.h),
                  CustomTextFormField(
                    controller: form.district,
                    hint: AppLocalizations.of(context)!.district_state,
                    validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.district_state_is_required : null,
                  ),

                  SizedBox(height: 16.h),
                  // ================= Gender =================
                  Row(
                    children: [
                      CustomText(text: AppLocalizations.of(context)!.gender, fontsize: 16.sp),
                      Text(' *', style: TextStyle(color: Colors.red, fontSize: 16.sp)),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Obx(() => CustomDropdown<GenderModel>(
                        hint: AppLocalizations.of(context)!.select_gender,
                        items: controller.genderList,
                        value: form.selectedGender.value,
                        itemToString: (item) => item.gender ?? "",
                        onChanged: (val) => form.selectedGender.value = val,
                      )),

                  SizedBox(height: 16.h),
                  // ================= NID / Passport =================
                  Row(
                    children: [
                      CustomText(text: AppLocalizations.of(context)!.nid_passport_no, fontsize: 16.sp),
                      Text(' *', style: TextStyle(color: Colors.red, fontSize: 16.sp)),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  CustomTextFormField(
                    controller: form.nid,
                    hint: AppLocalizations.of(context)!.nid_passport_no,
                    validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.nid_passport_no_is_required : null,
                  ),
                  SizedBox(height: 16.h),
                  CustomText(
                    text: AppLocalizations.of(context)!.nid_passport_documents,
                    fontsize: 16.sp,
                  ),
                  SizedBox(height: 4.h),

                  Obx(() {
                    return _buildFileRow(
                      pickedFile: form.selectedNidFile,
                      isDownloading: (controller.isDownloadingMap['userNidOrPassport'] ?? false).obs,
                      progress: (controller.downloadProgressMap['userNidOrPassport'] ?? 0.0).obs,
                      onPickFile: () async {
                        var result = await FilePickerUtil.pickSingleFile();
                        if (result != null) form.selectedNidFile.value = result;
                      },
                      onDownload: () async {
                        final isComplete = await controller.downloadFile(
                          urlPath: controller.profileModel.value.userProfile?.nidPaperUrl,
                          filePrefix: 'NID',
                          type: 'userNidOrPassport',
                        );
                        if (isComplete) {
                          Fluttertoast.showToast(
                            msg: AppLocalizations.of(context)!.nid_file_downloaded_successfully,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 2,
                            backgroundColor: AppColors.primaryColor,
                            textColor: AppColors.whiteColor,
                          );
                        }
                      },
                      fileUrl: controller.profileModel.value.userProfile?.nidPaperUrl,
                    );
                  }),
                  CustomText(
                    text: AppLocalizations.of(context)!.only_pdf_jpeg_png_file_are_allowed,
                    color: AppColors.redColor,
                    fontsize: 12.sp,
                  ),
                  SizedBox(height: 16.h),

                  // ================= TIN =================
                  CustomText(text: AppLocalizations.of(context)!.tin_tax_identification_number),
                  SizedBox(height: 4.h),
                  CustomTextFormField(
                    controller: form.tin,
                    hint: AppLocalizations.of(context)!.tin_tax_identification_number,
                    validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.tin_tax_identification_number_is_required : null,
                  ),
                  SizedBox(height: 16.h),
                  CustomText(
                    text: AppLocalizations.of(context)!.tin_documents,
                    fontsize: 16.sp,
                  ),
                  SizedBox(height: 4.h),

                  Obx(() => _buildFileRow(
                        pickedFile: form.selectedTinFile,
                        isDownloading: (controller.isDownloadingMap['userTinOrPassport'] ?? false).obs,
                        progress: (controller.downloadProgressMap['userTinOrPassport'] ?? 0.0).obs,
                        onPickFile: () async {
                          var result = await FilePickerUtil.pickSingleFile();
                          if (result != null) form.selectedTinFile.value = result;
                        },
                        onDownload: () async {
                          final isComplete = await controller.downloadFile(
                            urlPath: controller.profileModel.value.userProfile?.tinPaperUrl,
                            filePrefix: 'TIN',
                            type: 'userTinOrPassport',
                          );
                          if (isComplete) {
                            Fluttertoast.showToast(
                              msg: AppLocalizations.of(context)!.tin_file_downloaded_successfully,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 2,
                              backgroundColor: AppColors.primaryColor,
                              textColor: AppColors.whiteColor,
                            );
                          }
                        },
                        fileUrl: controller.profileModel.value.userProfile?.tinPaperUrl,
                      )),
                  CustomText(
                    text: AppLocalizations.of(context)!.only_pdf_jpeg_png_file_are_allowed,
                    color: AppColors.redColor,
                    fontsize: 12.sp,
                  ),
                  SizedBox(height: 16.h),

                  // ================= Multi Citizenship =================
                  CustomText(text: AppLocalizations.of(context)!.multi_citizenship),
                  SizedBox(height: 4.h),
                  Obx(
                    () => CustomDropdown<CountryModel>(
                      hint: AppLocalizations.of(context)!.select_country,
                      items: controller.countryList,
                      value: form.selectedMultiCitizenCountry.value,
                      itemToString: (item) => item.country ?? "",
                      onChanged: (val) => form.selectedMultiCitizenCountry.value = val,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  CustomText(
                    text: AppLocalizations.of(context)!.profile_picture,
                    fontsize: 16.sp,
                  ),
                  SizedBox(height: 4.h),

                  Obx(
                    () => _buildFileRow(
                      isDownloading: (controller.isDownloadingMap['userProfilePicture'] ?? false).obs,
                      progress: (controller.downloadProgressMap['userProfilePicture'] ?? 0.0).obs,
                      pickedFile: form.selectedProfilePictureFile,
                      onPickFile: () async {
                        var result = await FilePickerUtil.pickSingleFile();
                        if (result != null) form.selectedProfilePictureFile.value = result;
                      },
                      onDownload: () async {
                        final isComplete = await controller.downloadFile(
                          urlPath: controller.profileModel.value.userProfile?.profilePictureUrl,
                          filePrefix: 'ProfilePicture',
                          type: 'userProfilePicture',
                        );
                        if (isComplete) {
                          Fluttertoast.showToast(
                            msg: AppLocalizations.of(context)!.profile_picture_downloaded_successfully,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 2,
                            backgroundColor: AppColors.primaryColor,
                            textColor: AppColors.whiteColor,
                          );
                        }
                      },
                      fileUrl: controller.profileModel.value.userProfile?.profilePictureUrl,
                    ),
                  ),
                  CustomText(
                    text: AppLocalizations.of(context)!.only_pdf_jpeg_png_file_are_allowed,
                    color: AppColors.redColor,
                    fontsize: 12.sp,
                  ),
                  SizedBox(height: 16.h),
                  // ================= Button =================
                  CustomButtonCommon(
                    title: AppLocalizations.of(context)!.next,
                    onpress: () {
                      if (controller.step1formKey.currentState!.validate()) {
                        controller.onStepTapped(controller.currentStep.value + 1);
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
    });
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
                      AppLocalizations.of(context)!.choose_file,
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
                          pickedFile.value?.fileName ?? AppLocalizations.of(context)!.no_file_chosen,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: pickedFile.value == null ? Colors.grey : AppColors.hitTextColor000000,
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
                            width: 40.w, // increase size a bit for text visibility
                            height: 40.w,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  value: progress.value / 100,
                                  strokeWidth: 3,
                                  color: AppColors.whiteColor,
                                ),
                                Text(
                                  "${progress.value.toInt()}%",
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
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
