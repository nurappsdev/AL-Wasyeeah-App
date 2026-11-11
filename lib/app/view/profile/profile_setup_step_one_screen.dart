import 'dart:developer';

import 'package:wasiyyat/app/view/profile/controller/profile_controller.dart';
import 'package:wasiyyat/app/core/services/picker/file_picker_service.dart';
import 'package:wasiyyat/app/view/profile/model/country_list_model.dart';
import 'package:wasiyyat/app/view/profile/model/gender_list_model.dart';
import 'package:wasiyyat/app/view/profile/model/marital_list_model.dart';
import 'package:wasiyyat/app/view/profile/model/profession_list_model.dart';
import 'package:wasiyyat/app/core/utils/app_colors.dart';
import 'package:wasiyyat/app/core/widgets/custom_button_common.dart';
import 'package:wasiyyat/app/core/widgets/custom_dropdown.dart';
import 'package:wasiyyat/app/core/widgets/custom_text.dart';
import 'package:wasiyyat/app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:wasiyyat/app/core/widgets/file_choose_and_download_button.dart';
import 'package:wasiyyat/app/core/l10n/app_localizations.dart';

class ProfileSettingStepOneWidget extends StatefulWidget {
  const ProfileSettingStepOneWidget({super.key});

  @override
  State<ProfileSettingStepOneWidget> createState() =>
      _ProfileSettingStepOneWidgetState();
}

class _ProfileSettingStepOneWidgetState
    extends State<ProfileSettingStepOneWidget> {
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      final isLoading = controller.status.value.isLoading;

      if (controller.status.value.isError && !isLoading) {
        return Center(
          child: Text(
            AppLocalizations.of(context)!.something_went_wrong,
            style: TextStyle(color: isDark ? Colors.white : Colors.black87),
          ),
        );
      }

      final form = controller.personalForm.value;
      return Skeletonizer(
        enabled: isLoading,
        effect: ShimmerEffect(
          baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
          highlightColor: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
        ),
        containersColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        child: Form(
          key: controller.step1formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.h),
            child: RefreshIndicator(
              onRefresh: () => controller.getProfilePageData(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle(
                        AppLocalizations.of(context)!.personal_information),
                    // ================= First Name =================
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        CustomText(
                            text: AppLocalizations.of(context)!.first_name,
                            fontsize: 16.sp),
                        Text(' *',
                            style:
                                TextStyle(color: Colors.red, fontSize: 16.sp)),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.firstName,
                      hint: AppLocalizations.of(context)!.first_name,
                      validator: (value) => value!.isEmpty
                          ? AppLocalizations.of(context)!.first_name_is_required
                          : null,
                    ),

                    SizedBox(height: 16.h),
                    // ================= Last Name =================
                    Row(
                      children: [
                        CustomText(
                            text: AppLocalizations.of(context)!.last_name,
                            fontsize: 16.sp),
                        Text(' *',
                            style:
                                TextStyle(color: Colors.red, fontSize: 16.sp)),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.lastName,
                      hint: AppLocalizations.of(context)!.last_name,
                      validator: (value) => value!.isEmpty
                          ? AppLocalizations.of(context)!.last_name_is_required
                          : null,
                    ),

                    SizedBox(height: 16.h),
                    // ================= Marital Status =================
                    Row(
                      children: [
                        CustomText(
                            text: AppLocalizations.of(context)!.marital_status,
                            fontsize: 16.sp),
                        Text(' *',
                            style:
                                TextStyle(color: Colors.red, fontSize: 16.sp)),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Obx(
                      () => CustomDropdown<MaritalModel>(
                        hint:
                            AppLocalizations.of(context)!.select_marital_status,
                        items: controller.maritalList,
                        value: form.selectedMarried.value,
                        itemToString: (item) => item.maritalType ?? "",
                        onChanged: (val) {
                          form.selectedMarried.value = val;
                          log("Selected Married ${form.selectedMarried.value} ");
                        },
                        validator: (value) => value == null
                            ? AppLocalizations.of(context)!
                                .marital_status_is_required
                            : null,
                      ),
                    ),

                    SizedBox(height: 16.h),
                    // ================= Profession =================
                    CustomText(
                        text: AppLocalizations.of(context)!.profession,
                        fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    Obx(() => CustomDropdown<ProfessionModel>(
                          hint: AppLocalizations.of(context)!.select_profession,
                          items: controller.professionList,
                          value: form.selectedProfession.value,
                          itemToString: (item) => item.profession ?? "",
                          onChanged: (val) =>
                              form.selectedProfession.value = val,
                        )),

                    SizedBox(height: 16.h),
                    // ================= Place of Birth =================
                    Row(
                      children: [
                        CustomText(
                            text: AppLocalizations.of(context)!.place_of_birth,
                            fontsize: 16.sp),
                        // Text(' *',
                        //     style:
                        //         TextStyle(color: Colors.red, fontSize: 16.sp)),
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
                    Row(
                      children: [
                        CustomText(
                            text: AppLocalizations.of(context)!.district_state,
                            fontsize: 16.sp),
                        Text(' *',
                            style:
                                TextStyle(color: Colors.red, fontSize: 16.sp)),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.district,
                      hint: AppLocalizations.of(context)!.district_state,
                      validator: (value) => value!.isEmpty
                          ? AppLocalizations.of(context)!
                              .district_state_is_required
                          : null,
                    ),

                    SizedBox(height: 16.h),
                    // ================= Gender =================
                    Row(
                      children: [
                        CustomText(
                            text: AppLocalizations.of(context)!.gender,
                            fontsize: 16.sp),
                        // Text(' *',
                        //     style:
                        //         TextStyle(color: Colors.red, fontSize: 16.sp)),
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
                        CustomText(
                            text: AppLocalizations.of(context)!.nid_passport_no,
                            fontsize: 16.sp),
                        Text(' *',
                            style:
                                TextStyle(color: Colors.red, fontSize: 16.sp)),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.nid,
                      hint: AppLocalizations.of(context)!.nid_passport_no,
                      validator: (value) => value!.isEmpty
                          ? AppLocalizations.of(context)!
                              .nid_passport_no_is_required
                          : null,
                    ),
                    SizedBox(height: 16.h),
                    CustomText(
                      text:
                          AppLocalizations.of(context)!.nid_passport_documents,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 4.h),

                    _buildFileRow(
                      pickedFile: form.selectedNidFile,
                      fileUrl: controller
                          .profileModel.value.userProfile?.nidPaperUrl,
                      downloadType: 'userNidOrPassport',
                      prefix: 'NID',
                      successMessage: AppLocalizations.of(context)!
                          .nid_file_downloaded_successfully,
                      onPickFile: () async {
                        var result = await FilePickerUtil.pickSingleFile();
                        if (result != null) form.selectedNidFile.value = result;
                      },
                    ),
                    CustomText(
                      text: AppLocalizations.of(context)!
                          .only_pdf_jpeg_png_file_are_allowed,
                      color: AppColors.redColor,
                      fontsize: 12.sp,
                    ),
                    SizedBox(height: 16.h),

                    // ================= TIN =================
                    Row(
                      children: [
                        CustomText(
                            text: AppLocalizations.of(context)!
                                .tin_tax_identification_number),
                        Text(' *',
                            style:
                                TextStyle(color: Colors.red, fontSize: 16.sp)),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.tin,
                      hint: AppLocalizations.of(context)!
                          .tin_tax_identification_number,
                      validator: (value) => value!.isEmpty
                          ? AppLocalizations.of(context)!
                              .tin_tax_identification_number_is_required
                          : null,
                    ),
                    SizedBox(height: 16.h),
                    CustomText(
                      text: AppLocalizations.of(context)!.tin_documents,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 4.h),

                    _buildFileRow(
                      pickedFile: form.selectedTinFile,
                      fileUrl: controller
                          .profileModel.value.userProfile?.tinPaperUrl,
                      downloadType: 'userTinOrPassport',
                      prefix: 'TIN',
                      successMessage: AppLocalizations.of(context)!
                          .tin_file_downloaded_successfully,
                      onPickFile: () async {
                        var result = await FilePickerUtil.pickSingleFile();
                        if (result != null) form.selectedTinFile.value = result;
                      },
                    ),
                    CustomText(
                      text: AppLocalizations.of(context)!
                          .only_pdf_jpeg_png_file_are_allowed,
                      color: AppColors.redColor,
                      fontsize: 12.sp,
                    ),
                    SizedBox(height: 16.h),

                    // ================= Multi Citizenship =================
                    CustomText(
                        text: AppLocalizations.of(context)!.multi_citizenship),
                    SizedBox(height: 4.h),
                    Obx(
                      () => CustomDropdown<CountryModel>(
                        hint: AppLocalizations.of(context)!.select_country,
                        items: controller.countryList,
                        value: form.selectedMultiCitizenCountry.value,
                        itemToString: (item) => item.country ?? "",
                        onChanged: (val) =>
                            form.selectedMultiCitizenCountry.value = val,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    CustomText(
                      text: AppLocalizations.of(context)!.profile_picture,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 4.h),

                    _buildFileRow(
                      pickedFile: form.selectedProfilePictureFile,
                      fileUrl: controller
                          .profileModel.value.userProfile?.profilePictureUrl,
                      downloadType: 'userProfilePicture',
                      prefix: 'ProfilePicture',
                      successMessage: AppLocalizations.of(context)!
                          .profile_picture_downloaded_successfully,
                      onPickFile: () async {
                        var result = await FilePickerUtil.pickSingleFile();
                        if (result != null)
                          form.selectedProfilePictureFile.value = result;
                      },
                    ),
                    CustomText(
                      text: AppLocalizations.of(context)!
                          .only_pdf_jpeg_png_file_are_allowed,
                      color: AppColors.redColor,
                      fontsize: 12.sp,
                    ),
                    SizedBox(height: 16.h),
                    // ================= Button =================
                    CustomButton(
                      title: AppLocalizations.of(context)!.next,
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
        ),
      );
    });
  }

  // ---------------- File row helper ----------------
  Widget _buildFileRow({
    required Rxn<PickedFileResult> pickedFile,
    required VoidCallback onPickFile,
    String? fileUrl,
    required String downloadType,
    required String prefix,
    String? successMessage,
  }) {
    return Obx(() => FileChooseAndDownloadButton(
          pickedFile: pickedFile,
          isDownloading:
              (controller.isDownloadingMap[downloadType] ?? false).obs,
          progress: (controller.downloadProgressMap[downloadType] ?? 0.0).obs,
          onPickFile: onPickFile,
          onDownload: () async {
            final isComplete = await controller.downloadFile(
              urlPath: fileUrl,
              filePrefix: prefix,
              type: downloadType,
            );
            if (isComplete) {
              Fluttertoast.showToast(
                msg: successMessage ??
                    AppLocalizations.of(context)!.file_downloaded_successfully,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 2,
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.whiteColor,
              );
            }
          },
          fileUrl: fileUrl,
        ));
  }
}
