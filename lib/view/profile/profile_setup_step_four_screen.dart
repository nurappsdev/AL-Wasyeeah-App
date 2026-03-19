import 'package:al_wasyeah/helpers/file_picker_util.dart';
import 'package:al_wasyeah/controllers/profile/profile_controller.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/view/widgets/custom_button_common.dart';
import 'package:al_wasyeah/view/widgets/custom_dropdown.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:al_wasyeah/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widgets/file_choose_and_download_button.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/gender_list_model.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';

class ProfileSettingStepFourWidget extends StatelessWidget {
  ProfileSettingStepFourWidget({super.key});

  final ProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.step4formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Header =====
            _sectionTitle(AppLocalizations.of(context)!.family_information),

            // ===== Spouse forms =====
            _SpouseWidget(controller: controller),
            _sectionTitle(AppLocalizations.of(context)!.children_information),
            // ===== Children Information =====
            _ChildWidget(controller: controller),
            _sectionTitle(AppLocalizations.of(context)!.sibling_information),
            // ===== Sibling Information =====
            SiblingWidget(controller: controller),
            SizedBox(height: 20.h),

            Row(
              spacing: 16.w,
              children: [
                Expanded(
                  child: CustomButtonCommon(
                    title: AppLocalizations.of(context)!.previous,
                    onpress: () {
                      controller.onStepTapped(controller.currentStep.value - 1);
                    },
                  ),
                ),
                Expanded(
                  child: CustomButtonCommon(
                    title: AppLocalizations.of(context)!.next,
                    onpress: () {
                      if (controller.step4formKey.currentState!.validate()) {
                        controller
                            .onStepTapped(controller.currentStep.value + 1);
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Column(
      children: [
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
}

class SiblingWidget extends StatelessWidget {
  const SiblingWidget({
    super.key,
    required this.controller,
  });

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          children: [
            if (controller.siblingList.isEmpty)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.addSibling(),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 8.w),
                      Text(AppLocalizations.of(context)!.add_sibling)
                    ],
                  ),
                ),
              ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.siblingList.length,
              itemBuilder: (context, index) {
                final form = controller.siblingList[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 24.h),
                  padding: EdgeInsets.all(16.h),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                          color: Colors.black.withValues(alpha: 0.3))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(
                              text: AppLocalizations.of(context)!.sibling_name,
                              fontsize: 16.sp),
                          Text(' *',
                              style: TextStyle(
                                  color: Colors.red, fontSize: 16.sp)),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      CustomTextFormField(
                        controller: form.name,
                        hint: AppLocalizations.of(context)!.sibling_name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_name;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16.h),
                      // Gender
                      Row(
                        children: [
                          CustomText(
                              text: AppLocalizations.of(context)!.gender,
                              fontsize: 16.sp),
                          Text(' *',
                              style: TextStyle(
                                  color: Colors.red, fontSize: 16.sp)),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      CustomDropdown<GenderModel>(
                        hint: AppLocalizations.of(context)!.gender,
                        items: controller.genderList,
                        value: form.gender.value,
                        itemToString: (e) => e.gender ?? "",
                        onChanged: (v) => form.gender.value = v,
                      ),
                      SizedBox(height: 16.h),
                      // Profession
                      CustomText(
                        text: AppLocalizations.of(context)!.profession,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomDropdown<ProfessionModel>(
                        hint: AppLocalizations.of(context)!.profession,
                        items: controller.professionList,
                        value: form.profession.value,
                        itemToString: (e) => e.profession ?? "",
                        onChanged: (v) => form.profession.value = v,
                      ),
                      SizedBox(height: 16.h),
                      // Nationality
                      CustomText(
                        text: AppLocalizations.of(context)!.nationality,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomDropdown<CountryModel>(
                        hint: AppLocalizations.of(context)!.nationality,
                        items: controller.countryList,
                        value: form.nationality.value,
                        itemToString: (e) => e.country ?? "",
                        onChanged: (v) => form.nationality.value = v,
                      ),
                      SizedBox(height: 16.h),
                      // Date of Birth
                      Row(
                        children: [
                          CustomText(
                              text: AppLocalizations.of(context)!
                                  .sibling_date_of_birth,
                              fontsize: 16.sp),
                          Text(' *',
                              style: TextStyle(
                                  color: Colors.red, fontSize: 16.sp)),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Obx(
                        () => GestureDetector(
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate:
                                  form.selectedDob.value ?? DateTime.now(),
                              firstDate: DateTime(1930),
                              lastDate: DateTime.now(),
                            );
                            if (selectedDate != null) {
                              form.selectedDob.value = selectedDate;
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 16.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: form.selectedDob.value != null
                                      ? AppColors.primaryColor
                                      : Colors.grey,
                                  width: 2.w),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  form.selectedDob.value != null
                                      ? DateFormat('yyyy-MM-dd')
                                          .format(form.selectedDob.value!)
                                      : AppLocalizations.of(context)!
                                          .select_date_of_birth,
                                  style: TextStyle(
                                    color: form.selectedDob.value != null
                                        ? Colors.black
                                        : Colors.black54,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                Icon(Icons.calendar_month,
                                    color: AppColors.primaryColor),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // NID/Passport No
                      CustomText(
                        text: AppLocalizations.of(context)!.nid_passport_no,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomTextFormField(
                        controller: form.nid,
                        hint: AppLocalizations.of(context)!.nid_passport_no,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_nid_passport_no;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      Obx(
                        () => FileChooseAndDownloadButton(
                          pickedFile: form.selectedNidFile,
                          isDownloading: (controller.isDownloadingMap[
                                      'siblingNidOrPassport$index'] ??
                                  false)
                              .obs,
                          progress: (controller.downloadProgressMap[
                                      'siblingNidOrPassport$index'] ??
                                  0.0)
                              .obs,
                          onPickFile: () async {
                            var result = await FilePickerUtil.pickSingleFile();
                            if (result != null)
                              form.selectedNidFile.value = result;
                          },
                          onDownload: () async {
                            bool isComplete = await controller.downloadFile(
                              urlPath: form.nidUrl,
                              filePrefix: "Sibling",
                              type: 'siblingNidOrPassport$index',
                            );
                            if (isComplete) {
                              Fluttertoast.showToast(
                                msg:
                                    "${AppLocalizations.of(context)!.sibling} (${form.name.text}) ${AppLocalizations.of(context)!.nid_file_downloaded_successfully}"
                                        .tr,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 2,
                                backgroundColor: AppColors.primaryColor,
                                textColor: AppColors.whiteColor,
                              );
                            }
                          },
                          fileUrl: form.nidUrl,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // Mobile
                      CustomText(
                        text: AppLocalizations.of(context)!.mobile,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomTextFormField(
                        controller: form.mobile,
                        hint: AppLocalizations.of(context)!.mobile,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_mobile_number;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      // Email
                      CustomText(
                        text: AppLocalizations.of(context)!.email,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomTextFormField(
                        controller: form.email,
                        hint: AppLocalizations.of(context)!.email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_your_email;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      CustomText(
                        text: AppLocalizations.of(context)!
                            .sibling_existence_status,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      Center(
                        child: ToggleButtons(
                          isSelected: [form.isAlive.value, !form.isAlive.value],
                          onPressed: (i) => form.isAlive.value = i == 0,
                          borderRadius: BorderRadius.circular(8),
                          fillColor:
                              form.isAlive.value ? Colors.green : Colors.red,
                          selectedColor: Colors.white,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text(AppLocalizations.of(context)!.alive),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text(AppLocalizations.of(context)!.dead),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      //  if (index != 0)
                      Row(
                        spacing: 4.w,
                        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => controller.removeSibling(index),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.delete_forever,
                                      color: Colors.white),
                                  SizedBox(width: 8.w),
                                  Text(AppLocalizations.of(context)!.remove)
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () => controller.addSibling(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .add_more_sibling,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _ChildWidget extends StatelessWidget {
  const _ChildWidget({
    required this.controller,
  });

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          children: [
            if (controller.childrenList.isEmpty)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.addChild(),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 8.w),
                      Text(AppLocalizations.of(context)!.add_more_child)
                    ],
                  ),
                ),
              ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.childrenList.length,
              itemBuilder: (context, index) {
                final form = controller.childrenList[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 24.h),
                  padding: EdgeInsets.all(16.h),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                          color: Colors.black.withValues(alpha: 0.3))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(
                              text: AppLocalizations.of(context)!.child_name,
                              fontsize: 16.sp),
                          Text(' *',
                              style: TextStyle(
                                  color: Colors.red, fontSize: 16.sp)),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      CustomTextFormField(
                        controller: form.name,
                        hint: AppLocalizations.of(context)!.child_name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_name;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16.h),
                      // Gender
                      Row(
                        children: [
                          CustomText(
                              text: AppLocalizations.of(context)!.gender,
                              fontsize: 16.sp),
                          Text(' *',
                              style: TextStyle(
                                  color: Colors.red, fontSize: 16.sp)),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      CustomDropdown<GenderModel>(
                        hint: AppLocalizations.of(context)!.gender,
                        items: controller.genderList,
                        value: form.gender.value,
                        itemToString: (e) => e.gender ?? "",
                        onChanged: (v) => form.gender.value = v,
                      ),
                      SizedBox(height: 16.h),
                      // Profession
                      Row(
                        children: [
                          CustomText(
                              text: AppLocalizations.of(context)!.profession,
                              fontsize: 16.sp),
                          Text(' *',
                              style: TextStyle(
                                  color: Colors.red, fontSize: 16.sp)),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      CustomDropdown<ProfessionModel>(
                        hint: AppLocalizations.of(context)!.profession,
                        items: controller.professionList,
                        value: form.profession.value,
                        itemToString: (e) => e.profession ?? "",
                        onChanged: (v) => form.profession.value = v,
                      ),
                      SizedBox(height: 16.h),
                      // Nationality
                      Row(
                        children: [
                          CustomText(
                              text: AppLocalizations.of(context)!.nationality,
                              fontsize: 16.sp),
                          Text(' *',
                              style: TextStyle(
                                  color: Colors.red, fontSize: 16.sp)),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      CustomDropdown<CountryModel>(
                        hint: AppLocalizations.of(context)!.nationality,
                        items: controller.countryList,
                        value: form.nationality.value,
                        itemToString: (e) => e.country ?? "",
                        onChanged: (v) => form.nationality.value = v,
                      ),
                      SizedBox(height: 16.h),
                      // Date of Birth
                      Row(
                        children: [
                          CustomText(
                              text: AppLocalizations.of(context)!
                                  .child_date_of_birth,
                              fontsize: 16.sp),
                          Text(' *',
                              style: TextStyle(
                                  color: Colors.red, fontSize: 16.sp)),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Obx(
                        () => GestureDetector(
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate:
                                  form.selectedDob.value ?? DateTime.now(),
                              firstDate: DateTime(1930),
                              lastDate: DateTime.now(),
                            );
                            if (selectedDate != null) {
                              form.selectedDob.value = selectedDate;
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 16.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: form.selectedDob.value != null
                                      ? AppColors.primaryColor
                                      : Colors.grey,
                                  width: 2.w),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  form.selectedDob.value != null
                                      ? DateFormat('yyyy-MM-dd')
                                          .format(form.selectedDob.value!)
                                      : AppLocalizations.of(context)!
                                          .select_date_of_birth,
                                  style: TextStyle(
                                    color: form.selectedDob.value != null
                                        ? Colors.black
                                        : Colors.black54,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                Icon(Icons.calendar_month,
                                    color: AppColors.primaryColor),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // NID/Passport No
                      Row(
                        children: [
                          CustomText(
                              text:
                                  AppLocalizations.of(context)!.nid_passport_no,
                              fontsize: 16.sp),
                          Text(' *',
                              style: TextStyle(
                                  color: Colors.red, fontSize: 16.sp)),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      CustomTextFormField(
                        controller: form.nid,
                        hint: AppLocalizations.of(context)!.nid_passport_no,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_nid_passport_no;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      Obx(
                        () => FileChooseAndDownloadButton(
                          pickedFile: form.selectedNidFile,
                          isDownloading: (controller.isDownloadingMap[
                                      'childNidOrPassport$index'] ??
                                  false)
                              .obs,
                          progress: (controller.downloadProgressMap[
                                      'childNidOrPassport$index'] ??
                                  0.0)
                              .obs,
                          onPickFile: () async {
                            var result = await FilePickerUtil.pickSingleFile();
                            if (result != null)
                              form.selectedNidFile.value = result;
                          },
                          onDownload: () async {
                            bool isComplete = await controller.downloadFile(
                              urlPath: form.nidUrl,
                              filePrefix: "Child",
                              type: 'childNidOrPassport$index',
                            );
                            if (isComplete) {
                              Fluttertoast.showToast(
                                msg:
                                    "${AppLocalizations.of(context)!.child} (${form.name.text}) ${AppLocalizations.of(context)!.nid_file_downloaded_successfully}"
                                        .tr,
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 2,
                                backgroundColor: AppColors.primaryColor,
                                textColor: AppColors.whiteColor,
                              );
                            }
                          },
                          fileUrl: form.nidUrl,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // Mobile
                      CustomText(
                        text: AppLocalizations.of(context)!.mobile,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomTextFormField(
                        controller: form.mobile,
                        hint: AppLocalizations.of(context)!.mobile,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_mobile;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      // Email
                      CustomText(
                        text: AppLocalizations.of(context)!.email,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomTextFormField(
                        controller: form.email,
                        hint: AppLocalizations.of(context)!.email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_email;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      CustomText(
                        text: AppLocalizations.of(context)!
                            .child_existence_status,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      Center(
                        child: ToggleButtons(
                          isSelected: [form.isAlive.value, !form.isAlive.value],
                          onPressed: (i) => form.isAlive.value = i == 0,
                          borderRadius: BorderRadius.circular(8),
                          fillColor:
                              form.isAlive.value ? Colors.green : Colors.red,
                          selectedColor: Colors.white,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text(AppLocalizations.of(context)!.alive),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text(AppLocalizations.of(context)!.dead),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      //  if (index != 0)
                      Row(
                        spacing: 4.w,
                        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => controller.removeChild(index),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.delete_forever,
                                      color: Colors.white),
                                  SizedBox(width: 8.w),
                                  Text(AppLocalizations.of(context)!.remove)
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () => controller.addChild(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .add_more_child,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _SpouseWidget extends StatelessWidget {
  const _SpouseWidget({
    required this.controller,
  });

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          if (controller.spouseList.isEmpty)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.addSpouse(),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 8.w),
                    Text(AppLocalizations.of(context)!.add_spouse)
                  ],
                ),
              ),
            ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.spouseList.length,
            itemBuilder: (context, index) {
              final form = controller.spouseList[index];
              return Container(
                margin: EdgeInsets.only(bottom: 24.h),
                padding: EdgeInsets.all(16.h),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(24.r),
                    border:
                        Border.all(color: Colors.black.withValues(alpha: 0.3))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                            text: AppLocalizations.of(context)!.spouse_name,
                            fontsize: 16.sp),
                        Text(' *',
                            style:
                                TextStyle(color: Colors.red, fontSize: 16.sp)),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.name,
                      hint: AppLocalizations.of(context)!.spouse_name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_enter_name;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        CustomText(
                            text:
                                AppLocalizations.of(context)!.spouse_profession,
                            fontsize: 16.sp),
                        Text(' *',
                            style:
                                TextStyle(color: Colors.red, fontSize: 16.sp)),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    CustomDropdown<ProfessionModel>(
                      hint: AppLocalizations.of(context)!.profession,
                      items: controller.professionList,
                      value: form.profession.value,
                      itemToString: (e) => e.profession ?? "",
                      onChanged: (v) => form.profession.value = v,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        CustomText(
                          text:
                              AppLocalizations.of(context)!.spouse_nationality,
                          fontsize: 16.sp,
                        ),
                        Text(' *',
                            style:
                                TextStyle(color: Colors.red, fontSize: 16.sp)),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    CustomDropdown<CountryModel>(
                      hint: AppLocalizations.of(context)!.nationality,
                      items: controller.countryList,
                      value: form.nationality.value,
                      itemToString: (e) => e.country ?? "",
                      onChanged: (v) => form.nationality.value = v,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        CustomText(
                          text: AppLocalizations.of(context)!
                              .spouse_date_of_birth,
                          fontsize: 16.sp,
                        ),
                        Text(' *',
                            style:
                                TextStyle(color: Colors.red, fontSize: 16.sp)),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Obx(
                      () => GestureDetector(
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate:
                                form.selectedDob.value ?? DateTime.now(),
                            firstDate: DateTime(1930),
                            lastDate: DateTime.now(),
                          );
                          if (selectedDate != null) {
                            form.selectedDob.value = selectedDate;
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: form.selectedDob.value != null
                                    ? AppColors.primaryColor
                                    : Colors.grey,
                                width: 2.w),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                form.selectedDob.value != null
                                    ? DateFormat('yyyy-MM-dd')
                                        .format(form.selectedDob.value!)
                                    : AppLocalizations.of(context)!
                                        .select_date_of_birth,
                                style: TextStyle(
                                  color: form.selectedDob.value != null
                                      ? Colors.black
                                      : Colors.black54,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Icon(Icons.calendar_month,
                                  color: AppColors.primaryColor),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        CustomText(
                          text: AppLocalizations.of(context)!.nid_passport_no,
                          fontsize: 16.sp,
                        ),
                        Text(' *',
                            style:
                                TextStyle(color: Colors.red, fontSize: 16.sp)),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.nid,
                      hint: AppLocalizations.of(context)!.nid_passport_no,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_enter_nid_passport_no;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomText(
                      text:
                          AppLocalizations.of(context)!.nid_passport_documents,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 4.h),
                    Obx(
                      () => FileChooseAndDownloadButton(
                        pickedFile: form.selectedNidFile,
                        isDownloading: (controller.isDownloadingMap[
                                    'spouseNidOrPassport$index'] ??
                                false)
                            .obs,
                        progress: (controller.downloadProgressMap[
                                    'spouseNidOrPassport$index'] ??
                                0.0)
                            .obs,
                        onPickFile: () async {
                          var result = await FilePickerUtil.pickSingleFile();
                          if (result != null)
                            form.selectedNidFile.value = result;
                        },
                        onDownload: () async {
                          bool isComplete = await controller.downloadFile(
                            urlPath: form.nidUrl,
                            filePrefix: "Spouse",
                            type: 'spouseNidOrPassport$index',
                          );
                          if (isComplete) {
                            Fluttertoast.showToast(
                              msg:
                                  "${AppLocalizations.of(context)!.spouse} (${form.name.text}) ${AppLocalizations.of(context)!.nid_file_downloaded_successfully}"
                                      .tr,
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 2,
                              backgroundColor: AppColors.primaryColor,
                              textColor: AppColors.whiteColor,
                            );
                          }
                        },
                        fileUrl: form.nidUrl,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        CustomText(
                          text: AppLocalizations.of(context)!.spouse +
                              " " +
                              AppLocalizations.of(context)!.mobile,
                          fontsize: 16.sp,
                        ),
                        Text(' *',
                            style:
                                TextStyle(color: Colors.red, fontSize: 16.sp)),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.mobile,
                      hint: AppLocalizations.of(context)!.mobile,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_enter_mobile_number;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomText(
                      text: AppLocalizations.of(context)!.spouse +
                          " " +
                          AppLocalizations.of(context)!.email,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.email,
                      hint: AppLocalizations.of(context)!.email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_enter_email;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomText(
                      text: AppLocalizations.of(context)!.spouse +
                          " " +
                          AppLocalizations.of(context)!.existence_status,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 4.h),
                    Obx(
                      () => Center(
                        child: ToggleButtons(
                          isSelected: [form.isAlive.value, !form.isAlive.value],
                          onPressed: (i) => form.isAlive.value = i == 0,
                          borderRadius: BorderRadius.circular(8),
                          fillColor:
                              form.isAlive.value ? Colors.green : Colors.red,
                          selectedColor: Colors.white,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text(AppLocalizations.of(context)!.alive),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text(AppLocalizations.of(context)!.dead),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    //   if (index != 0)
                    Row(
                      spacing: 4.w,
                      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => controller.removeSpouse(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.delete_forever, color: Colors.white),
                                SizedBox(width: 8.w),
                                Text(AppLocalizations.of(context)!.remove)
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () => controller.addSpouse(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!.add_more_spouse,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      );
    });
  }
}
// Updated
