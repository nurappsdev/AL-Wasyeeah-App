import 'dart:developer';
import 'package:al_wasyeah/helpers/file_picker_util.dart';
import 'package:al_wasyeah/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/widgets.dart';
import '../../widgets/file_choose_and_download_button.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/gender_list_model.dart';

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
            _sectionTitle('familyInformation'),

            // ===== Spouse forms =====
            _SpouseWidget(controller: controller),
            _sectionTitle('childrenInformation'),
            // ===== Children Information =====
            _ChildWidget(controller: controller),
            _sectionTitle('siblingInformation'),
            // ===== Sibling Information =====
            SiblingWidget(controller: controller),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Column(
      children: [
        Container(
          height: 48,
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(8),
          child: Text(
            title.tr,
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
        SizedBox(height: 16),
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
                  margin: EdgeInsets.only(bottom: 24),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                          color: Colors.black.withValues(alpha: 0.3))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'siblingName'.tr,
                        fontsize: 16,
                      ),
                      SizedBox(height: 4),
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

                      SizedBox(height: 16),
                      // Gender
                      CustomText(
                        text: 'gender'.tr,
                        fontsize: 16,
                      ),
                      SizedBox(height: 4),
                      CustomDropdown<GenderModel>(
                        hint: 'gender'.tr,
                        items: controller.genderList,
                        value: form.gender.value,
                        itemToString: (e) => e.gender ?? "",
                        onChanged: (v) => form.gender.value = v,
                      ),
                      SizedBox(height: 16),
                      // Profession
                      CustomText(
                        text: 'profession'.tr,
                        fontsize: 16,
                      ),
                      SizedBox(height: 4),
                      CustomDropdown<ProfessionModel>(
                        hint: 'profession'.tr,
                        items: controller.professionList,
                        value: form.profession.value,
                        itemToString: (e) => e.profession ?? "",
                        onChanged: (v) => form.profession.value = v,
                      ),
                      SizedBox(height: 16),
                      // Nationality
                      CustomText(
                        text: 'nationality'.tr,
                        fontsize: 16,
                      ),
                      SizedBox(height: 4),
                      CustomDropdown<CountryModel>(
                        hint: 'nationality'.tr,
                        items: controller.countryList,
                        value: form.nationality.value,
                        itemToString: (e) => e.country ?? "",
                        onChanged: (v) => form.nationality.value = v,
                      ),
                      SizedBox(height: 16),
                      // Date of Birth
                      CustomText(
                        text: 'siblingDob'.tr,
                        fontsize: 16,
                      ),
                      SizedBox(height: 4),
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
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: form.selectedDob.value != null
                                      ? AppColors.primaryColor
                                      : Colors.grey,
                                  width: 2),
                              borderRadius: BorderRadius.circular(8),
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
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(Icons.calendar_month,
                                    color: AppColors.primaryColor),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      // NID/Passport No
                      CustomText(
                        text: "NID/Passport No".tr,
                        fontsize: 16,
                      ),
                      SizedBox(height: 4),
                      CustomTextFormField(
                        controller: form.nid,
                        hint: "NID/Passport No".tr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'nidPassportNoRequired'.tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
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
                                    "Sibling (${form.name.text}) ${'fileDownloadedSuccess'.tr}",
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
                      SizedBox(height: 16),
                      // Mobile
                      CustomText(
                        text: "Mobile".tr,
                        fontsize: 16,
                      ),
                      SizedBox(height: 4),
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
                      SizedBox(height: 16),
                      // Email
                      CustomText(
                        text: "Email".tr,
                        fontsize: 16,
                      ),
                      SizedBox(height: 4),
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
                      SizedBox(height: 16),

                      CustomText(
                        text: 'siblingExistenceStatus'.tr,
                        fontsize: 16,
                      ),
                      SizedBox(height: 4),
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
                        height: 16,
                      ),
                      //  if (index != 0)
                      Row(
                        spacing: 4,
                        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => controller.removeSibling(index),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.delete_forever,
                                      color: Colors.white),
                                  SizedBox(width: 8),
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
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'addMoreSibling'.tr,
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
                  margin: EdgeInsets.only(bottom: 24),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                          color: Colors.black.withValues(alpha: 0.3))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'childName'.tr,
                        fontsize: 16,
                      ),
                      SizedBox(height: 4),
                      CustomTextFormField(
                        controller: form.name,
                        hint: 'childName'.tr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'nameRequired'.tr;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16),
                      // Gender
                      CustomText(
                        text: 'gender'.tr,
                        fontsize: 16,
                      ),
                      SizedBox(height: 4),
                      CustomDropdown<GenderModel>(
                        hint: 'gender'.tr,
                        items: controller.genderList,
                        value: form.gender.value,
                        itemToString: (e) => e.gender ?? "",
                        onChanged: (v) => form.gender.value = v,
                      ),
                      SizedBox(height: 16),
                      // Profession
                      CustomText(
                        text: 'profession'.tr,
                        fontsize: 16,
                      ),
                      SizedBox(height: 4),
                      CustomDropdown<ProfessionModel>(
                        hint: 'profession'.tr,
                        items: controller.professionList,
                        value: form.profession.value,
                        itemToString: (e) => e.profession ?? "",
                        onChanged: (v) => form.profession.value = v,
                      ),
                      SizedBox(height: 16),
                      // Nationality
                      CustomText(
                        text: 'nationality'.tr,
                        fontsize: 16,
                      ),
                      SizedBox(height: 4),
                      CustomDropdown<CountryModel>(
                        hint: 'nationality'.tr,
                        items: controller.countryList,
                        value: form.nationality.value,
                        itemToString: (e) => e.country ?? "",
                        onChanged: (v) => form.nationality.value = v,
                      ),
                      SizedBox(height: 16),
                      // Date of Birth
                      CustomText(
                        text: 'childDob'.tr,
                        fontsize: 16,
                      ),
                      SizedBox(height: 4),
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
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: form.selectedDob.value != null
                                      ? AppColors.primaryColor
                                      : Colors.grey,
                                  width: 2),
                              borderRadius: BorderRadius.circular(8),
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
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(Icons.calendar_month,
                                    color: AppColors.primaryColor),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      // NID/Passport No
                      CustomText(
                        text: "NID/Passport No".tr,
                        fontsize: 16,
                      ),
                      SizedBox(height: 4),
                      CustomTextFormField(
                        controller: form.nid,
                        hint: "NID/Passport No".tr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'nidPassportNoRequired'.tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
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
                                    "Child (${form.name.text}) ${'fileDownloadedSuccess'.tr}",
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
                      SizedBox(height: 16),
                      // Mobile
                      CustomText(
                        text: "Mobile".tr,
                        fontsize: 16,
                      ),
                      SizedBox(height: 4),
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
                      SizedBox(height: 16),
                      // Email
                      CustomText(
                        text: "Email".tr,
                        fontsize: 16,
                      ),
                      SizedBox(height: 4),
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
                      SizedBox(height: 16),

                      CustomText(
                        text: 'childExistenceStatus'.tr,
                        fontsize: 16,
                      ),
                      SizedBox(height: 4),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Text('alive'.tr),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Text('dead'.tr),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      //  if (index != 0)
                      Row(
                        spacing: 4,
                        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => controller.removeChild(index),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.delete_forever,
                                      color: Colors.white),
                                  SizedBox(width: 8),
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
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'addMoreChild'.tr,
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
                margin: EdgeInsets.only(bottom: 24),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(24),
                    border:
                        Border.all(color: Colors.black.withValues(alpha: 0.3))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'spouseName'.tr,
                      fontsize: 16,
                    ),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      controller: form.name,
                      hint: 'spouseName'.tr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'nameRequired'.tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    CustomText(
                      text: 'spouseProfession'.tr,
                      fontsize: 16,
                    ),
                    SizedBox(height: 4),
                    CustomDropdown<ProfessionModel>(
                      hint: 'profession'.tr,
                      items: controller.professionList,
                      value: form.profession.value,
                      itemToString: (e) => e.profession ?? "",
                      onChanged: (v) => form.profession.value = v,
                    ),
                    SizedBox(height: 16),
                    CustomText(
                      text: 'spouseNationality'.tr,
                      fontsize: 16,
                    ),
                    SizedBox(height: 4),
                    CustomDropdown<CountryModel>(
                      hint: 'nationality'.tr,
                      items: controller.countryList,
                      value: form.nationality.value,
                      itemToString: (e) => e.country ?? "",
                      onChanged: (v) => form.nationality.value = v,
                    ),
                    SizedBox(height: 16),
                    CustomText(
                      text: 'spouseDob'.tr,
                      fontsize: 16,
                    ),
                    SizedBox(height: 4),
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
                              horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: form.selectedDob.value != null
                                    ? AppColors.primaryColor
                                    : Colors.grey,
                                width: 2),
                            borderRadius: BorderRadius.circular(8),
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
                                  fontSize: 16,
                                ),
                              ),
                              Icon(Icons.calendar_month,
                                  color: AppColors.primaryColor),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    CustomText(
                      text: 'spouseNidPassportNo'.tr,
                      fontsize: 16,
                    ),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      controller: form.nid,
                      hint: "NID/Passport No".tr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'nidPassportNoRequired'.tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    CustomText(
                      text: 'spouseNidPassportDocuments'.tr,
                      fontsize: 16,
                    ),
                    SizedBox(height: 4),
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
                                  "Spouse (${form.name.text}) ${'fileDownloadedSuccess'.tr}",
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
                    SizedBox(height: 16),
                    CustomText(
                      text: 'spouseMobileNo'.tr,
                      fontsize: 16,
                    ),
                    SizedBox(height: 4),
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
                    SizedBox(height: 16),
                    CustomText(
                      text: 'spouseEmail'.tr,
                      fontsize: 16,
                    ),
                    SizedBox(height: 4),
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
                    SizedBox(height: 16),
                    CustomText(
                      text: 'spouseExistenceStatus'.tr,
                      fontsize: 16,
                    ),
                    SizedBox(height: 4),
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
                      height: 16,
                    ),
                    //   if (index != 0)
                    Row(
                      spacing: 4,
                      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => controller.removeSpouse(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.delete_forever, color: Colors.white),
                                SizedBox(width: 8),
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
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'addMoreSpouse'.tr,
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



