import 'package:al_wasyeah/helpers/file_picker_util.dart';
import 'package:al_wasyeah/models/profile_info_model/parent_form.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/view/widgets/custom_button_common.dart';
import 'package:al_wasyeah/view/widgets/custom_dropdown.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:al_wasyeah/view/widgets/custom_text_field.dart';
import 'package:al_wasyeah/view/widgets/file_choose_and_download_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../../utils/utils.dart';

import 'package:al_wasyeah/l10n/app_localizations.dart';

class ProfileSettingStepThreeWidget extends StatelessWidget {
  ProfileSettingStepThreeWidget({super.key});
  final ProfileController controller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    ParentForm form = controller.parentForm.value;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: SingleChildScrollView(
        child: Form(
          key: controller.step3formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ========== Father ==========
              _parentSection(
                title: "Father's Information",
                nameController: form.fatherName,
                nidController: form.fatherPassOrNID,
                selectedProfession: form.selectedFatherProfession,
                isAlive: form.isFatherAlive,
                fileUrl: controller.profileModel.value.parentInfo?.fatherNidUrl,
                pickedFile: form.selectedFatherFile,
                onPickFile: () async {
                  var result = await FilePickerUtil.pickSingleFile();
                  if (result != null) form.selectedFatherFile.value = result;
                },
                downloadType: 'fatherNidOrPassport',
                filePrefix: 'FatherNidOrPassport',
              ),

              SizedBox(height: 24.h),

              /// ========== Mother ==========
              _parentSection(
                title: "Mother's Information",
                nameController: form.motherName,
                nidController: form.motherPassOrNID,
                selectedProfession: form.selectedMotherProfession,
                isAlive: form.isMotherAlive,
                fileUrl: controller.profileModel.value.parentInfo?.motherNidUrl,
                pickedFile: form.selectedMotherFile,
                onPickFile: () async {
                  var result = await FilePickerUtil.pickSingleFile();
                  if (result != null) form.selectedMotherFile.value = result;
                },
                downloadType: 'motherNidOrPassport',
                filePrefix: 'MotherNidOrPassport',
              ),

              SizedBox(height: 20.h),
              Row(
                spacing: 16.w,
                children: [
                  Expanded(
                    child: CustomButtonCommon(
                      title: "Previous".tr,
                      onpress: () {
                        controller
                            .onStepTapped(controller.currentStep.value - 1);
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomButtonCommon(
                      title: AppLocalizations.of(context)!.next,
                      onpress: () {
                        if (controller.step3formKey.currentState!.validate()) {
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
      ),
    );
  }

  /// ================= Helpers =================
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

  Widget _parentSection({
    required String title,
    required TextEditingController nameController,
    required TextEditingController nidController,
    required Rxn<ProfessionModel> selectedProfession,
    required RxBool isAlive,
    required String? fileUrl,
    required Rxn<PickedFileResult> pickedFile,
    required VoidCallback onPickFile,
    required String downloadType,
    required String filePrefix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(title),
        _textField("Name", nameController),
        _professionDropdown(selectedProfession),
        _textField("NID/Passport No", nidController),
        CustomText(
          text: "NID/Passport Documents".tr,
          fontsize: 16.sp,
        ),
        SizedBox(height: 4.h),
        if (fileUrl != null)
          _buildFileRow(
              fileUrl, pickedFile, onPickFile, downloadType, filePrefix),
        CustomText(
          text: "* Only Pdf, JPEG, PNG file are allowed".tr,
          color: AppColors.redColor,
          fontsize: 12.sp,
        ),
        SizedBox(height: 16.h),
        CustomText(
          text: "Existence Status".tr,
          fontsize: 16.sp,
        ),
        SizedBox(height: 4.h),
        Obx(
          () => Center(
            child: ToggleButtons(
              isSelected: [isAlive.value, !isAlive.value],
              onPressed: (i) => isAlive.value = i == 0,
              borderRadius: BorderRadius.circular(8),
              fillColor: isAlive.value ? Colors.green : Colors.red,
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
      ],
    );
  }

  Widget _textField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText(text: label.tr, fontsize: 16.sp),
            Text(' *', style: TextStyle(color: Colors.red, fontSize: 16.sp)),
          ],
        ),
        SizedBox(height: 4.h),
        CustomTextFormField(
          controller: controller,
          hint: label.tr,
          validator: (value) => value!.isEmpty ? "$label is required" : null,
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _professionDropdown(Rxn<ProfessionModel> selectedProfession) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            text: AppLocalizations.of(Get.context!)!.profession,
            fontsize: 16.sp),
        SizedBox(height: 4.h),
        Obx(() => CustomDropdown<ProfessionModel>(
              hint: AppLocalizations.of(Get.context!)!.profession,
              items: controller.professionList,
              value: selectedProfession.value,
              itemToString: (item) => item.profession ?? "",
              onChanged: (val) => selectedProfession.value = val,
            )),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildFileRow(
    String fileUrl,
    Rxn<PickedFileResult> pickedFile,
    VoidCallback onPickFile,
    String downloadType,
    String prefix,
  ) {
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
                msg: "File downloaded successfully".tr,
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
