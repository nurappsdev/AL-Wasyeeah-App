import 'dart:developer';

import 'package:al_wasyeah/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../../widgets/file_choose_and_download_button.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/gender_list_model.dart';

class ProfileSetupStepFourScreen extends StatelessWidget {
  ProfileSetupStepFourScreen({super.key});

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
            _sectionTitle("Family Information".tr),

            // ===== Spouse forms =====
            _SpouseWidget(controller: controller),
            _sectionTitle("Children Information".tr),
            // ===== Children Information =====
            _ChildWidget(controller: controller),
            _sectionTitle("Sibling Information".tr),
            // ===== Sibling Information =====
            SiblingWidget(controller: controller),
            SizedBox(height: 20.h),
            CustomButtonCommon(
              title: "Next".tr,
              onpress: () {
                if (controller.step4formKey.currentState!.validate()) {
                  controller.onStepTapped(controller.currentStep.value + 1);
                } else {
                  log("Not validate");
                }
              },
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
                      CustomText(
                        text: "Sibling Name".tr,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomTextFormField(
                        controller: form.name,
                        hint: "Sibling Name".tr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter name".tr;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16.h),
                      // Gender
                      CustomText(
                        text: "Gender".tr,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomDropdown<GenderModel>(
                        hint: "Gender".tr,
                        items: controller.genderList,
                        value: form.gender.value,
                        itemToString: (e) => e.gender ?? "",
                        onChanged: (v) => form.gender.value = v,
                      ),
                      SizedBox(height: 16.h),
                      // Profession
                      CustomText(
                        text: "Profession".tr,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomDropdown<ProfessionModel>(
                        hint: "Profession".tr,
                        items: controller.professionList,
                        value: form.profession.value,
                        itemToString: (e) => e.profession ?? "",
                        onChanged: (v) => form.profession.value = v,
                      ),
                      SizedBox(height: 16.h),
                      // Nationality
                      CustomText(
                        text: "Nationality".tr,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomDropdown<CountryModel>(
                        hint: "Nationality".tr,
                        items: controller.countryList,
                        value: form.nationality.value,
                        itemToString: (e) => e.country ?? "",
                        onChanged: (v) => form.nationality.value = v,
                      ),
                      SizedBox(height: 16.h),
                      // Date of Birth
                      CustomText(
                        text: "Sibling Date of Birth".tr,
                        fontsize: 16.sp,
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
                                      : "Select Date of Birth".tr,
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
                        text: "NID/Passport No".tr,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomTextFormField(
                        controller: form.nid,
                        hint: "NID/Passport No".tr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter NID/Passport No".tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      Obx(
                        () => FileChooseAndDownloadButton(
                          pickedFile: Rxn(controller
                              .pickedFileMap['siblingNidOrPassport$index']),
                          isDownloading: (controller.isDownloadingMap[
                                      'siblingNidOrPassport$index'] ??
                                  false)
                              .obs,
                          progress: (controller.downloadProgressMap[
                                      'siblingNidOrPassport$index'] ??
                                  0.0)
                              .obs,
                          onPickFile: () =>
                              controller.pickFile('siblingNidOrPassport$index'),
                          onDownload: () async {
                            bool isComplete = await controller.downloadFile(
                              urlPath: form.nidUrl,
                              filePrefix: "Sibling",
                              type: 'siblingNidOrPassport$index',
                            );
                            if (isComplete) {
                              Fluttertoast.showToast(
                                msg:
                                    "Sibling (${form.name.text}) NID File downloaded successfully"
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
                        text: "Mobile".tr,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomTextFormField(
                        controller: form.mobile,
                        hint: "Mobile".tr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Mobile".tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      // Email
                      CustomText(
                        text: "Email".tr,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomTextFormField(
                        controller: form.email,
                        hint: "Email".tr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Email".tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      CustomText(
                        text: "Sibling Existence Status".tr,
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
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text("Alive"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text("Dead"),
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
                                  Text("Remove".tr)
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
                                    "Add More Sibling".tr,
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
                      CustomText(
                        text: "Child Name".tr,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomTextFormField(
                        controller: form.name,
                        hint: "Child Name".tr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter name".tr;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16.h),
                      // Gender
                      CustomText(
                        text: "Gender".tr,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomDropdown<GenderModel>(
                        hint: "Gender".tr,
                        items: controller.genderList,
                        value: form.gender.value,
                        itemToString: (e) => e.gender ?? "",
                        onChanged: (v) => form.gender.value = v,
                      ),
                      SizedBox(height: 16.h),
                      // Profession
                      CustomText(
                        text: "Profession".tr,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomDropdown<ProfessionModel>(
                        hint: "Profession".tr,
                        items: controller.professionList,
                        value: form.profession.value,
                        itemToString: (e) => e.profession ?? "",
                        onChanged: (v) => form.profession.value = v,
                      ),
                      SizedBox(height: 16.h),
                      // Nationality
                      CustomText(
                        text: "Nationality".tr,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomDropdown<CountryModel>(
                        hint: "Nationality".tr,
                        items: controller.countryList,
                        value: form.nationality.value,
                        itemToString: (e) => e.country ?? "",
                        onChanged: (v) => form.nationality.value = v,
                      ),
                      SizedBox(height: 16.h),
                      // Date of Birth
                      CustomText(
                        text: "Child Date of Birth".tr,
                        fontsize: 16.sp,
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
                                      : "Select Date of Birth".tr,
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
                        text: "NID/Passport No".tr,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomTextFormField(
                        controller: form.nid,
                        hint: "NID/Passport No".tr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter NID/Passport No".tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      Obx(
                        () => FileChooseAndDownloadButton(
                          pickedFile: Rxn(controller
                              .pickedFileMap['childNidOrPassport$index']),
                          isDownloading: (controller.isDownloadingMap[
                                      'childNidOrPassport$index'] ??
                                  false)
                              .obs,
                          progress: (controller.downloadProgressMap[
                                      'childNidOrPassport$index'] ??
                                  0.0)
                              .obs,
                          onPickFile: () =>
                              controller.pickFile('childNidOrPassport$index'),
                          onDownload: () async {
                            bool isComplete = await controller.downloadFile(
                              urlPath: form.nidUrl,
                              filePrefix: "Child",
                              type: 'childNidOrPassport$index',
                            );
                            if (isComplete) {
                              Fluttertoast.showToast(
                                msg:
                                    "Child (${form.name.text}) NID File downloaded successfully"
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
                        text: "Mobile".tr,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomTextFormField(
                        controller: form.mobile,
                        hint: "Mobile".tr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Mobile".tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      // Email
                      CustomText(
                        text: "Email".tr,
                        fontsize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      CustomTextFormField(
                        controller: form.email,
                        hint: "Email".tr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Email".tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      CustomText(
                        text: "Child Existence Status".tr,
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
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text("Alive"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text("Dead"),
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
                                  Text("Remove".tr)
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
                                    "Add More Child".tr,
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
    super.key,
    required this.controller,
  });

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
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
                    CustomText(
                      text: "Spouse Name".tr,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.name,
                      hint: "Spouse Name".tr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter name".tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomText(
                      text: "Spouse Profession".tr,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 4.h),
                    CustomDropdown<ProfessionModel>(
                      hint: "Profession".tr,
                      items: controller.professionList,
                      value: form.profession.value,
                      itemToString: (e) => e.profession ?? "",
                      onChanged: (v) => form.profession.value = v,
                    ),
                    SizedBox(height: 16.h),
                    CustomText(
                      text: "Spouse Nationality".tr,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 4.h),
                    CustomDropdown<CountryModel>(
                      hint: "Nationality".tr,
                      items: controller.countryList,
                      value: form.nationality.value,
                      itemToString: (e) => e.country ?? "",
                      onChanged: (v) => form.nationality.value = v,
                    ),
                    SizedBox(height: 16.h),
                    CustomText(
                      text: "Spouse Date of Birth".tr,
                      fontsize: 16.sp,
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
                                    : "Select Date of Birth".tr,
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
                    CustomText(
                      text: "Spouse NID/Passport No".tr,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.nid,
                      hint: "NID/Passport No".tr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter NID/Passport No".tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomText(
                      text: "Spouse NID/Passport Documents".tr,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 4.h),
                    Obx(
                      () => FileChooseAndDownloadButton(
                        pickedFile: Rxn(controller
                            .pickedFileMap['spouseNidOrPassport$index']),
                        isDownloading: (controller.isDownloadingMap[
                                    'spouseNidOrPassport$index'] ??
                                false)
                            .obs,
                        progress: (controller.downloadProgressMap[
                                    'spouseNidOrPassport$index'] ??
                                0.0)
                            .obs,
                        onPickFile: () =>
                            controller.pickFile('spouseNidOrPassport$index'),
                        onDownload: () async {
                          bool isComplete = await controller.downloadFile(
                            urlPath: form.nidUrl,
                            filePrefix: "Spouse",
                            type: 'spouseNidOrPassport$index',
                          );
                          if (isComplete) {
                            Fluttertoast.showToast(
                              msg:
                                  "Spouse (${form.name.text}) NID File downloaded successfully"
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
                    CustomText(
                      text: "Spouse Mobile No".tr,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.mobile,
                      hint: "Mobile".tr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter mobile".tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomText(
                      text: "Spouse Email".tr,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.email,
                      hint: "Email".tr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter email".tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomText(
                      text: "Spouse Existence Status".tr,
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
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text("Alive"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text("Dead"),
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
                                Text("Remove".tr)
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
                                  "Add More Spouse".tr,
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
