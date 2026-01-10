import 'dart:developer';

import 'package:al_wasyeah/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../../widgets/file_choose_and_download_button.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/gender_list_model.dart';

class FamilyInfoScreen extends StatelessWidget {
  FamilyInfoScreen({super.key});

  final ProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== Header =====
          _sectionTitle("Family Information".tr),

          // ===== Spouse forms =====
          Obx(() {
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
                      ),
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
                              onPickFile: () => controller
                                  .pickFile('spouseNidOrPassport$index'),
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
                                isSelected: [
                                  form.isAlive.value,
                                  !form.isAlive.value
                                ],
                                onPressed: (i) => form.isAlive.value = i == 0,
                                borderRadius: BorderRadius.circular(8),
                                fillColor: form.isAlive.value
                                    ? Colors.green
                                    : Colors.red,
                                selectedColor: Colors.white,
                                children: const [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 40),
                                    child: Text("Alive"),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 40),
                                    child: Text("Dead"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          if (index != 0)
                            Center(
                              child: SizedBox(
                                width: 0.5.sw,
                                child: ElevatedButton(
                                  onPressed: () =>
                                      controller.removeSpouse(index),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                            ),
                        ],
                      ),
                    );
                  },
                ),

                // ===== Add More Button =====
                Padding(
                  padding: EdgeInsets.only(left: 50.w, right: 10, bottom: 10.h),
                  child: CustomButton(
                    title: "+ Add More spouse",
                    titlecolor: AppColors.primaryColor,
                    onpress: controller.addSpouse,
                  ),
                ),
              ],
            );
          }),

          Obx(
            () {
              return Column(
                children: [
                  // ===== Children Information =====
                  _sectionTitle("Children Information".tr),

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
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Child Name".tr,
                              fontsize: 16.sp,
                            ),
                            SizedBox(height: 10.h),
                            CustomTextField(controller: form.name),
                            SizedBox(height: 20.h),
                            // Gender
                            CustomDropdown<GenderModel>(
                              hint: "Gender".tr,
                              items: controller.genderList,
                              value: form.gender.value,
                              itemToString: (e) => e.gender ?? "",
                              onChanged: (v) => form.gender.value = v,
                            ),
                            SizedBox(height: 20.h),
                            CustomDropdown<ProfessionModel>(
                              hint: "Profession".tr,
                              items: controller.professionList,
                              value: form.profession.value,
                              itemToString: (e) => e.profession ?? "",
                              onChanged: (v) => form.profession.value = v,
                            ),
                            SizedBox(height: 20.h),
                            CustomDropdown<CountryModel>(
                              hint: "Nationality".tr,
                              items: controller.countryList,
                              value: form.nationality.value,
                              itemToString: (e) => e.country ?? "",
                              onChanged: (v) => form.nationality.value = v,
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              controller: form.nid,
                              hintText: "NID/Passport No".tr,
                            ),
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
                                onPickFile: () => controller
                                    .pickFile('childNidOrPassport$index'),
                                onDownload: () async {
                                  bool isComplete =
                                      await controller.downloadFile(
                                    urlPath: form.nidUrl,
                                    filePrefix: "Child",
                                    type: 'childNidOrPassport$index',
                                  );
                                  if (isComplete) {
                                    Fluttertoast.showToast(
                                      msg:
                                          "Child (${form.name.text}) NID File downloaded successfully"
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
                            SizedBox(height: 20.h),
                            CustomTextField(
                                controller: form.mobile, hintText: "Mobile".tr),
                            SizedBox(height: 16.h),
                            CustomTextField(
                                controller: form.email, hintText: "Email".tr),
                            SizedBox(height: 16.h),
                            Center(
                              child: ToggleButtons(
                                isSelected: [
                                  form.isAlive.value,
                                  !form.isAlive.value
                                ],
                                onPressed: (i) => form.isAlive.value = i == 0,
                                borderRadius: BorderRadius.circular(8),
                                fillColor: form.isAlive.value
                                    ? Colors.green
                                    : Colors.red,
                                selectedColor: Colors.white,
                                children: const [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 40),
                                    child: Text("Alive"),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 40),
                                    child: Text("Dead"),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            if (index != 0)
                              Center(
                                child: SizedBox(
                                  width: 0.5.sw,
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        controller.removeChild(index),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.delete_forever,
                                            color: Colors.white),
                                        SizedBox(width: 8.w),
                                        Text("Remove".tr)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),

                  // ===== Add More Child Button =====
                  Padding(
                    padding:
                        EdgeInsets.only(left: 50.w, right: 10, bottom: 10.h),
                    child: CustomButton(
                      title: "+ Add More Child".tr,
                      titlecolor: AppColors.primaryColor,
                      onpress: controller.addChild,
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }

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
}
