import 'dart:io';

import 'package:al_wasyeah/controllers/profile/parent_form.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/view/widgets/file_choose_and_download_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/controllers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

import '../../../controllers/profile/profile_enum.dart';

class ProfileSetupStepThreeScreen extends StatelessWidget {
  ProfileSetupStepThreeScreen({super.key});

  final ProfileController controller = Get.find<ProfileController>();

  ParentForm get form => controller.parentForm.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              /// ========== Father ==========
              _parentSection(
                title: "Father's Information",
                nameController: form.fatherName,
                nidController: form.fatherPassOrNID,
                selectedProfession: form.selectedFatherProfession,
                isAlive: form.isFatherAlive,
                fileUrl: controller.profileModel.value.parentInfo?.fatherNidUrl,
                pickerType: 'fatherNidOrPassport',
                downloadType: 'fatherNidOrPassport',
                filePrefix: 'FatherNidOrPassport',
              ),

              /// ========== Mother ==========
              _parentSection(
                title: "Mother's Information",
                nameController: form.motherName,
                nidController: form.motherPassOrNID,
                selectedProfession: form.selectedMotherProfession,
                isAlive: form.isMotherAlive,
                fileUrl: controller.profileModel.value.parentInfo?.motherNidUrl,
                pickerType: 'motherNidOrPassport',
                downloadType: 'motherNidOrPassport',
                filePrefix: 'MotherNidOrPassport',
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= Helpers =================

  Widget _parentSection({
    required String title,
    required TextEditingController nameController,
    required TextEditingController nidController,
    required Rxn<ProfessionModel> selectedProfession,
    required RxBool isAlive,
    required String? fileUrl,
    required String pickerType,
    required String downloadType,
    required String filePrefix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title.tr, fontsize: 18.sp),
        SizedBox(height: 12.h),
        _textField("Name", nameController),
        _professionDropdown(selectedProfession),
        _textField("NID/Passport No", nidController),
        if (fileUrl != null)
          _filePicker(fileUrl, pickerType, downloadType, filePrefix),
        CustomText(
          text: "* Only Pdf, JPEG, PNG file are allowed".tr,
          color: AppColors.redColor,
          fontsize: 12.sp,
        ),
        SizedBox(height: 12.h),
        AliveDeadToggle(isAlive: isAlive),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _textField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: label.tr, fontsize: 16.sp),
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
        CustomText(text: "Profession".tr, fontsize: 16.sp),
        SizedBox(height: 4.h),
        Obx(() => CustomDropdown<ProfessionModel>(
              hint: "Profession".tr,
              items: controller.professionList,
              value: selectedProfession.value,
              itemToString: (item) => item.profession ?? "",
              onChanged: (val) => selectedProfession.value = val,
            )),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _filePicker(
    String fileUrl,
    String pickerType,
    String downloadType,
    String prefix,
  ) {
    return Obx(() => FileChooseAndDownloadButton(
          pickedFile: Rxn(controller.pickedFileMap[pickerType]),
          isDownloading:
              (controller.isDownloadingMap[downloadType] ?? false).obs,
          progress: (controller.downloadProgressMap[downloadType] ?? 0.0).obs,
          onPickFile: () => controller.pickFile(pickerType),
          onDownload: () => controller.downloadFile(
            urlPath: fileUrl,
            filePrefix: prefix,
            type: downloadType,
          ),
          fileUrl: fileUrl,
        ));
  }
}

class AliveDeadToggle extends StatelessWidget {
  final RxBool isAlive;
  AliveDeadToggle({required this.isAlive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: Obx(() => Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => isAlive(true),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isAlive.value ? Colors.green : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isAlive.value ? Colors.green : Colors.grey,
                      ),
                    ),
                    child: Text(
                      'Alive',
                      style: TextStyle(
                        color: isAlive.value ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: InkWell(
                  onTap: () => isAlive(false),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: !isAlive.value ? Colors.green : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: !isAlive.value ? Colors.green : Colors.grey,
                      ),
                    ),
                    child: Text(
                      'Dead',
                      style: TextStyle(
                        color: !isAlive.value ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
