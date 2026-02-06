import 'package:al_wasyeah/helpers/file_picker_util.dart';
import 'package:al_wasyeah/models/profile_info_model/parent_form.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/view/widgets/file_choose_and_download_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/widgets.dart';

class ProfileSettingStepThreeWidget extends StatelessWidget {
  ProfileSettingStepThreeWidget({super.key});
  final ProfileController controller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    ParentForm form = controller.parentForm.value;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: SingleChildScrollView(
          child: Form(
            key: controller.step3formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ========== Father ==========
                _parentSection(
                  title: 'fatherInformation'.tr,
                  nameController: form.fatherName,
                  nidController: form.fatherPassOrNID,
                  selectedProfession: form.selectedFatherProfession,
                  isAlive: form.isFatherAlive,
                  fileUrl:
                      controller.profileModel.value.parentInfo?.fatherNidUrl,
                  pickedFile: form.selectedFatherFile,
                  onPickFile: () async {
                    var result = await FilePickerUtil.pickSingleFile();
                    if (result != null) form.selectedFatherFile.value = result;
                  },
                  downloadType: 'fatherNidOrPassport',
                  filePrefix: 'FatherNidOrPassport',
                ),

                SizedBox(height: 24),

                /// ========== Mother ==========
                _parentSection(
                  title: 'motherInformation'.tr,
                  nameController: form.motherName,
                  nidController: form.motherPassOrNID,
                  selectedProfession: form.selectedMotherProfession,
                  isAlive: form.isMotherAlive,
                  fileUrl:
                      controller.profileModel.value.parentInfo?.motherNidUrl,
                  pickedFile: form.selectedMotherFile,
                  onPickFile: () async {
                    var result = await FilePickerUtil.pickSingleFile();
                    if (result != null) form.selectedMotherFile.value = result;
                  },
                  downloadType: 'motherNidOrPassport',
                  filePrefix: 'MotherNidOrPassport',
                ),

                SizedBox(height: 20),
                CustomButtonCommon(
                  title: 'next'.tr,
                  onpress: () {
                    if (controller.step3formKey.currentState!.validate()) {
                      controller.onStepTapped(controller.currentStep.value + 1);
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
  }

  /// ================= Helpers =================
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
        _textField('name'.tr, nameController, 'nameRequired'.tr),
        _professionDropdown(selectedProfession),
        _textField('nidPassportNo'.tr, nidController,
            'nidPassportNoRequired'.tr),
        CustomText(
          text: 'nidPassportDocuments'.tr,
          fontsize: 16,
        ),
        SizedBox(height: 4),
        if (fileUrl != null)
          _filePicker(
              fileUrl, pickedFile, onPickFile, downloadType, filePrefix),
        CustomText(
          text: 'fileAllowedWarning'.tr,
          color: AppColors.redColor,
          fontsize: 12,
        ),
        SizedBox(height: 16),
        CustomText(
          text: 'existenceStatus'.tr,
          fontsize: 16,
        ),
        SizedBox(height: 4),
        Obx(
          () => Center(
            child: ToggleButtons(
              isSelected: [isAlive.value, !isAlive.value],
              onPressed: (i) => isAlive.value = i == 0,
              borderRadius: BorderRadius.circular(8),
              fillColor: isAlive.value ? Colors.green : Colors.red,
              selectedColor: Colors.white,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text('alive'.tr),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text('dead'.tr),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _textField(
      String label, TextEditingController controller, String error) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: label.tr, fontsize: 16),
        SizedBox(height: 4),
        CustomTextFormField(
          controller: controller,
          hint: label.tr,
          validator: (value) => value!.isEmpty ? error : null,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _professionDropdown(Rxn<ProfessionModel> selectedProfession) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: 'profession'.tr, fontsize: 16),
        SizedBox(height: 4),
        Obx(() => CustomDropdown<ProfessionModel>(
              hint: 'profession'.tr,
              items: controller.professionList,
              value: selectedProfession.value,
              itemToString: (item) => item.profession ?? "",
              onChanged: (val) => selectedProfession.value = val,
            )),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _filePicker(
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
                msg: 'fileDownloadedSuccess'.tr,
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


