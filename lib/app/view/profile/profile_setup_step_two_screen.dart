import 'package:al_wasyeah/app/view/profile/controller/profile_controller.dart';
import 'package:al_wasyeah/app/view/profile/model/address_form.dart';
import 'package:al_wasyeah/app/view/profile/model/country_list_model.dart';
import 'package:al_wasyeah/app/core/utils/app_colors.dart';
import 'package:al_wasyeah/app/core/widgets/custom_button_common.dart';
import 'package:al_wasyeah/app/core/widgets/custom_dropdown.dart';
import 'package:al_wasyeah/app/core/widgets/custom_text.dart';
import 'package:al_wasyeah/app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:al_wasyeah/app/core/l10n/app_localizations.dart';

class ProfileSettingStepTwoWidget extends StatefulWidget {
  const ProfileSettingStepTwoWidget({super.key});

  @override
  State<ProfileSettingStepTwoWidget> createState() => _ProfileSettingStepTwoWidgetState();
}

class _ProfileSettingStepTwoWidgetState extends State<ProfileSettingStepTwoWidget> {
  final ProfileController controller = Get.find<ProfileController>();

  AddressForm get form => controller.addressForm.value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: SingleChildScrollView(
        child: Form(
          key: controller.step2formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ========= Present Address =========
              _sectionTitle(AppLocalizations.of(Get.context!)!.present_address),

              _textField(
                label: AppLocalizations.of(Get.context!)!.zip_code,
                controller: form.presentZipCode,
              ),
              _textField(
                label: AppLocalizations.of(Get.context!)!.village_house,
                controller: form.presentVillage,
              ),
              _textField(
                label: AppLocalizations.of(Get.context!)!.road_block_section,
                controller: form.presentRoad,
              ),

              /// ========= Permanent Address =========
              Obx(() => CheckboxListTile(
                    value: form.isPresentAddressAsPermanentAddress.value,
                    onChanged: (value) {
                      form.isPresentAddressAsPermanentAddress.value = value!;
                      if (value) {
                        form.permanentZipCode.text = form.presentZipCode.text;
                        form.permanentVillage.text = form.presentVillage.text;
                        form.permanentRoad.text = form.presentRoad.text;
                      } else {
                        form.permanentZipCode.clear();
                        form.permanentVillage.clear();
                        form.permanentRoad.clear();
                      }
                    },
                    title: Text(
                      AppLocalizations.of(Get.context!)!.mark_present_address_as_permanent_address,
                    ),
                  )),

              _sectionTitle(AppLocalizations.of(Get.context!)!.permanent_address),

              _textField(
                label: AppLocalizations.of(Get.context!)!.zip_code,
                controller: form.permanentZipCode,
              ),
              _textField(
                label: AppLocalizations.of(Get.context!)!.village_house,
                controller: form.permanentVillage,
              ),
              _textField(
                label: AppLocalizations.of(Get.context!)!.road_block_section,
                controller: form.permanentRoad,
              ),

              /// ========= Overseas Address =========
              _sectionTitle(AppLocalizations.of(Get.context!)!.overseas_address),
              CustomText(text: AppLocalizations.of(Get.context!)!.country, fontsize: 16.sp),
              Obx(() => CustomDropdown<CountryModel>(
                    hint: AppLocalizations.of(Get.context!)!.select_country,
                    items: controller.countryList,
                    value: form.selectedOverseasCountry.value,
                    itemToString: (item) => item.country ?? "",
                    onChanged: (val) => form.selectedOverseasCountry.value = val,
                  )),

              _textField(
                label: AppLocalizations.of(Get.context!)!.village_house,
                controller: form.overseasVillage,
                isRequired: false,
              ),

              /// ========= Button =========
              SizedBox(height: 20.h),

              Row(
                spacing: 16.w,
                children: [
                  Expanded(
                    child: CustomButton(
                      title: "Previous".tr,
                      onpress: () {
                        controller.onStepTapped(controller.currentStep.value - 1);
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      title: AppLocalizations.of(context)!.next,
                      onpress: () {
                        if (controller.step2formKey.currentState!.validate()) {
                          controller.onStepTapped(controller.currentStep.value + 1);
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

  /// ---------- Helpers ----------

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

  Widget _textField({
    required String label,
    required TextEditingController controller,
    bool isRequired = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText(text: label.tr, fontsize: 16.sp),
            if (isRequired) Text(' *', style: TextStyle(color: Colors.red, fontSize: 16.sp)),
          ],
        ),
        SizedBox(height: 4.h),
        CustomTextFormField(
          controller: controller,
          hint: label.tr,
          validator: isRequired ? (value) => value!.isEmpty ? "$label is required" : null : null,
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
