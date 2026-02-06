import 'dart:developer';

import 'package:al_wasyeah/helpers/file_picker_util.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/gender_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/marital_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../controllers/controllers.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/widgets.dart';

class ProfileSettingStepOneWidget extends StatefulWidget {
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
        SizedBox(height: 16),
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
          return Center(child: Text('somethingWentWrong'.tr));
        }

        final form = controller.personalForm.value;
        return Form(
          key: controller.step1formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: RefreshIndicator(
              onRefresh: () => controller.getProfilePageData(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('personalInformation'),
                    // ================= First Name =================
                    const SizedBox(height: 16),
                    CustomText(
                      text: 'firstName'.tr,
                      fontsize: 16,
                    ),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      controller: form.firstName,
                      hint: 'firstName'.tr,
                      validator: (value) => value!.isEmpty
                          ? 'enterFirstNameError'.tr
                          : null,
                    ),

                    SizedBox(height: 16),
                    // ================= Last Name =================
                    CustomText(
                      text: 'lastName'.tr,
                      fontsize: 16,
                    ),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      controller: form.lastName,
                      hint: 'lastName'.tr,
                      validator: (value) => value!.isEmpty
                          ? 'enterLastNameError'.tr
                          : null,
                    ),

                    SizedBox(height: 16),
                    // ================= Marital Status =================
                    CustomText(
                        text: 'maritalStatus'.tr, fontsize: 16),
                    SizedBox(height: 4),
                    Obx(() => CustomDropdown<MaritalModel>(
                          hint: 'selectMaritalStatus'.tr,
                          items: controller.maritalList,
                          value: form.selectedMarried.value,
                          itemToString: (item) => item.maritalType ?? "",
                          onChanged: (val) => form.selectedMarried.value = val,
                          validator: (value) => value == null
                              ? 'maritalStatusRequired'.tr
                              : null,
                        )),

                    SizedBox(height: 16),
                    // ================= Profession =================
                    CustomText(text: 'profession'.tr, fontsize: 16),
                    SizedBox(height: 4),
                    Obx(() => CustomDropdown<ProfessionModel>(
                          hint: 'selectProfession'.tr,
                          items: controller.professionList,
                          value: form.selectedProfession.value,
                          itemToString: (item) => item.profession ?? "",
                          onChanged: (val) =>
                              form.selectedProfession.value = val,
                        )),

                    SizedBox(height: 16),
                    // ================= Place of Birth =================
                    CustomText(
                        text: 'placeOfBirth'.tr, fontsize: 16),
                    SizedBox(height: 4),
                    Obx(() => CustomDropdown<CountryModel>(
                          hint: 'selectCountry'.tr,
                          items: controller.countryList,
                          value: form.selectedCountry.value,
                          itemToString: (item) => item.country ?? "",
                          onChanged: (val) => form.selectedCountry.value = val,
                        )),

                    SizedBox(height: 16),
                    // ================= District/State =================
                    CustomText(
                        text: 'districtState'.tr, fontsize: 16),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      controller: form.district,
                      hint: 'districtState'.tr,
                      validator: (value) => value!.isEmpty
                          ? 'districtStateRequired'.tr
                          : null,
                    ),

                    SizedBox(height: 16),
                    // ================= Gender =================
                    CustomText(text: 'gender'.tr, fontsize: 16),
                    SizedBox(height: 4),
                    Obx(() => CustomDropdown<GenderModel>(
                          hint: 'selectGender'.tr,
                          items: controller.genderList,
                          value: form.selectedGender.value,
                          itemToString: (item) => item.gender ?? "",
                          onChanged: (val) => form.selectedGender.value = val,
                        )),

                    SizedBox(height: 16),
                    // ================= NID / Passport =================
                    CustomText(
                        text: 'nidPassportNo'.tr, fontsize: 16),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      controller: form.nid,
                      hint: 'nidPassportNo'.tr,
                      validator: (value) => value!.isEmpty
                          ? 'nidPassportNoRequired'.tr
                          : null,
                    ),
                    SizedBox(height: 16),
                    CustomText(
                      text: 'nidPassportDocuments'.tr,
                      fontsize: 16,
                    ),
                    SizedBox(height: 4),
                    if (form.nid.text.isNotEmpty)
                      Obx(() {
                        return _buildFileRow(
                          pickedFile: form.selectedNidFile,
                          isDownloading: (controller
                                      .isDownloadingMap['userNidOrPassport'] ??
                                  false)
                              .obs,
                          progress: (controller.downloadProgressMap[
                                      'userNidOrPassport'] ??
                                  0.0)
                              .obs,
                          onPickFile: () async {
                            var result = await FilePickerUtil.pickSingleFile();
                            if (result != null)
                              form.selectedNidFile.value = result;
                          },
                          onDownload: () async {
                            final isComplete = await controller.downloadFile(
                              urlPath: controller
                                  .profileModel.value.userProfile?.nidPaperUrl,
                              filePrefix: 'NID',
                              type: 'userNidOrPassport',
                            );
                            if (isComplete) {
                              Fluttertoast.showToast(
                                msg: 'nidDownloaded'.tr,
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
                      text: 'fileAllowedWarning'.tr,
                      color: AppColors.redColor,
                      fontsize: 12,
                    ),
                    SizedBox(height: 16),

                    // ================= TIN =================
                    CustomText(text: 'tinFull'.tr),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      controller: form.tin,
                      hint: 'tin'.tr,
                      validator: (value) =>
                          value!.isEmpty ? 'tinRequired'.tr : null,
                    ),
                    SizedBox(height: 16),
                    CustomText(
                      text: 'tinDocuments'.tr,
                      fontsize: 16,
                    ),
                    SizedBox(height: 4),
                    if (controller
                            .profileModel.value.userProfile?.tinPaperUrl !=
                        null)
                      Obx(() => _buildFileRow(
                            pickedFile: form.selectedTinFile,
                            isDownloading: (controller.isDownloadingMap[
                                        'userTinOrPassport'] ??
                                    false)
                                .obs,
                            progress: (controller.downloadProgressMap[
                                        'userTinOrPassport'] ??
                                    0.0)
                                .obs,
                            onPickFile: () async {
                              var result =
                                  await FilePickerUtil.pickSingleFile();
                              if (result != null)
                                form.selectedTinFile.value = result;
                            },
                            onDownload: () async {
                              final isComplete = await controller.downloadFile(
                                urlPath: controller.profileModel.value
                                    .userProfile?.tinPaperUrl,
                                filePrefix: 'TIN',
                                type: 'userTinOrPassport',
                              );
                              if (isComplete) {
                                Fluttertoast.showToast(
                                  msg: 'tinDownloaded'.tr,
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
                      text: 'fileAllowedWarning'.tr,
                      color: AppColors.redColor,
                      fontsize: 12,
                    ),
                    SizedBox(height: 16),

                    // ================= Multi Citizenship =================
                    CustomText(text: "Multi Citizenship".tr),
                    SizedBox(height: 4),
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomDropdown<CountryModel>(
                            hint: 'selectCountry'.tr,
                            items: controller.countryList,
                            value: form.selectedMultiCitizenCountry.value,
                            itemToString: (item) => item.country ?? "",
                            onChanged: (val) =>
                                form.selectedMultiCitizenCountry.value = val,
                          ),
                          SizedBox(height: 16),
                          CustomText(
                            text: 'nidPassportNo'.tr,
                            fontsize: 16,
                          ),
                          SizedBox(height: 4),
                          CustomTextFormField(
                            controller: form.multiCitizenPassport,
                            hint: 'passportNo'.tr,
                          ),
                          SizedBox(height: 16),
                          CustomText(
                            text: 'nidPassportDocuments'.tr,
                            fontsize: 16,
                          ),
                          SizedBox(height: 4),
                          if (controller.profileModel.value.userProfile
                                  ?.passportPaperUrl !=
                              null)
                            _buildFileRow(
                              isDownloading: (controller.isDownloadingMap[
                                          'userMultiCitizenOrPassport'] ??
                                      false)
                                  .obs,
                              progress: (controller.downloadProgressMap[
                                          'userMultiCitizenOrPassport'] ??
                                      0.0)
                                  .obs,
                              pickedFile: form.selectedMultiCitizenFile,
                              onPickFile: () async {
                                var result =
                                    await FilePickerUtil.pickSingleFile();
                                if (result != null)
                                  form.selectedMultiCitizenFile.value = result;
                              },
                              onDownload: () async {
                                final isComplete =
                                    await controller.downloadFile(
                                  urlPath: controller.profileModel.value
                                      .userProfile?.passportPaperUrl,
                                  filePrefix: 'MultiCitizen',
                                  type: 'userMultiCitizenOrPassport',
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
                              fileUrl: controller.profileModel.value.userProfile
                                  ?.passportPaperUrl,
                            ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),
                    // ================= Button =================
                    CustomButtonCommon(
                      title: 'next'.tr,
                      onpress: () {
                        if (controller.step1formKey.currentState!.validate()) {
                          controller
                              .onStepTapped(controller.currentStep.value + 1);
                        }
                      },
                    ),
                    SizedBox(height: 20),
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
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
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
                      size: 20,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(width: 8),

                    // Choose file text
                    Text(
                      'chooseFile'.tr,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),

                    ...[
                      SizedBox(width: 12),

                      // Divider
                      Container(
                        height: 18,
                        width: 1,
                        color: AppColors.primaryColor.withOpacity(0.4),
                      ),

                      SizedBox(width: 12),

                      // File name or placeholder
                      Expanded(
                        child: Text(
                          pickedFile.value?.fileName ??
                              'noFileChosen'.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
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
          SizedBox(width: 6),
          if (fileUrl != null)
            InkWell(
              onTap: isDownloading.value ? null : onDownload,
              child: Container(
                width: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Obx(() {
                  return isDownloading.value
                      ? Center(
                          child: SizedBox(
                            width: 22,
                            height: 22,
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
//             padding: EdgeInsets.symmetric(horizontal: 14),
//             child: RefreshIndicator(
//               onRefresh: controller.getProfilePageData(),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     /// ---------- First Name ----------
//                     const SizedBox(height: 16),
//                     CustomText(text: "First Name".tr, fontsize: 16),
//                     SizedBox(height: 4),
//                     CustomTextFormField(
//                       controller: form.value.firstName,
//                       hint: "First Name".tr,
//                       validator: (v) =>
//                           v!.isEmpty ? "First Name is required" : null,
//                     ),

//                     /// ---------- Last Name ----------
//                     SizedBox(height: 16),
//                     CustomText(text: "Last Name".tr, fontsize: 16),
//                     SizedBox(height: 4),
//                     CustomTextFormField(
//                       controller: form.value.lastName,
//                       hint: "Last Name".tr,
//                       validator: (v) =>
//                           v!.isEmpty ? "Last Name is required" : null,
//                     ),

//                     /// ---------- Marital Status ----------
//                     SizedBox(height: 16),
//                     CustomText(text: "Marital Status".tr, fontsize: 16),
//                     SizedBox(height: 4),
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
//                     SizedBox(height: 16),
//                     CustomText(text: "Profession".tr, fontsize: 16),
//                     SizedBox(height: 4),
//                     Obx(() => CustomDropdown<ProfessionModel>(
//                           hint: "Select Profession",
//                           items: controller.professionList,
//                           value: form.value.selectedProfession.value,
//                           itemToString: (e) => e.profession ?? '',
//                           onChanged: (v) =>
//                               form.value.selectedProfession.value = v,
//                         )),

//                     /// ---------- Place of Birth ----------
//                     SizedBox(height: 16),
//                     CustomText(text: "Place of Birth".tr, fontsize: 16),
//                     SizedBox(height: 4),
//                     Obx(() => CustomDropdown<CountryModel>(
//                           hint: "Select Country",
//                           items: controller.countryList,
//                           value: form.value.selectedCountry.value,
//                           itemToString: (e) => e.country ?? '',
//                           onChanged: (v) =>
//                               form.value.selectedCountry.value = v,
//                         )),

//                     /// ---------- District ----------
//                     SizedBox(height: 16),
//                     CustomText(text: "District/State".tr, fontsize: 16),
//                     SizedBox(height: 4),
//                     CustomTextFormField(
//                       controller: form.value.district,
//                       hint: "District/State".tr,
//                       validator: (v) =>
//                           v!.isEmpty ? "District/State is required" : null,
//                     ),

//                     /// ---------- Gender ----------
//                     SizedBox(height: 16),
//                     CustomText(text: "Gender".tr, fontsize: 16),
//                     SizedBox(height: 4),
//                     Obx(() => CustomDropdown<GenderModel>(
//                           hint: "Select Gender",
//                           items: controller.genderList,
//                           value: form.value.selectedGender.value,
//                           itemToString: (e) => e.gender ?? '',
//                           onChanged: (v) => form.value.selectedGender.value = v,
//                         )),

//                     /// ---------- NID ----------
//                     SizedBox(height: 16),
//                     CustomText(text: "NID/Passport No".tr, fontsize: 16),
//                     SizedBox(height: 4),
//                     CustomTextFormField(
//                       controller: form.value.nid,
//                       hint: "NID/Passport No".tr,
//                       validator: (v) =>
//                           v!.isEmpty ? "NID/Passport No is required" : null,
//                     ),

//                     /// ---------- TIN ----------
//                     SizedBox(height: 16),
//                     CustomText(text: "TIN".tr),
//                     SizedBox(height: 4),
//                     CustomTextFormField(
//                       controller: form.value.tin,
//                       hint: "TIN".tr,
//                       validator: (v) => v!.isEmpty ? "TIN is required" : null,
//                     ),

//                     /// ---------- Multi Citizenship ----------
//                     SizedBox(height: 16),
//                     CustomText(text: "Multi Citizenship".tr),
//                     SizedBox(height: 4),
//                     Obx(() => CustomDropdown<CountryModel>(
//                           hint: "Select Country",
//                           items: controller.countryList,
//                           value: form.value.selectedMultiCitizenCountry.value,
//                           itemToString: (e) => e.country ?? '',
//                           onChanged: (v) =>
//                               form.value.selectedMultiCitizenCountry.value = v,
//                         )),
//                     SizedBox(height: 10),
//                     CustomTextFormField(
//                       controller: form.value.multiCitizenPassport,
//                       hint: "Passport No".tr,
//                     ),

//                     /// ---------- Next Button ----------
//                     SizedBox(height: 20),
//                     CustomButtonCommon(
//                       title: "Next".tr,
//                       onpress: () {
//                         if (controller.step1formKey.currentState!.validate()) {
//                           controller
//                               .onStepTapped(controller.currentStep.value + 1);
//                         }
//                       },
//                     ),
//                     SizedBox(height: 30),
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



