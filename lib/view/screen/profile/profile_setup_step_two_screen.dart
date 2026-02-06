import 'package:al_wasyeah/models/profile_info_model/address_form.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/widgets.dart';

class ProfileSettingStepTwoWidget extends StatefulWidget {
  const ProfileSettingStepTwoWidget({super.key});

  @override
  State<ProfileSettingStepTwoWidget> createState() =>
      _ProfileSettingStepTwoWidgetState();
}

class _ProfileSettingStepTwoWidgetState
    extends State<ProfileSettingStepTwoWidget> {
  final ProfileController controller = Get.find<ProfileController>();

  AddressForm get form => controller.addressForm.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: SingleChildScrollView(
          child: Form(
            key: controller.step2formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ========= Present Address =========
                _sectionTitle('presentAddress'),

                _textField(
                  label: 'zipCode'.tr,
                  controller: form.presentZipCode,
                  error: 'zipCodeRequired'.tr,
                ),
                _textField(
                  label: 'villageHouse'.tr,
                  controller: form.presentVillage,
                  error: 'villageHouseRequired'.tr,
                ),
                _textField(
                  label: 'roadBlockSection'.tr,
                  controller: form.presentRoad,
                  error: 'roadBlockSectionRequired'.tr,
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
                        'markAsPermanent'.tr,
                      ),
                    )),

                _sectionTitle('permanentAddress'),

                _textField(
                  label: 'zipCode'.tr,
                  controller: form.permanentZipCode,
                  error: 'zipCodeRequired'.tr,
                ),
                _textField(
                  label: 'villageHouse'.tr,
                  controller: form.permanentVillage,
                  error: 'villageHouseRequired'.tr,
                ),
                _textField(
                  label: 'roadBlockSection'.tr,
                  controller: form.permanentRoad,
                  error: 'roadBlockSectionRequired'.tr,
                ),

                /// ========= Overseas Address =========
                _sectionTitle('overseasAddress'),

                Obx(() => CustomDropdown<CountryModel>(
                      hint: 'selectCountry'.tr,
                      items: controller.countryList,
                      value: form.selectedOverseasCountry.value,
                      itemToString: (item) => item.country ?? "",
                      onChanged: (val) =>
                          form.selectedOverseasCountry.value = val,
                    )),

                _textField(
                  label: 'villageHouse'.tr,
                  controller: form.overseasVillage,
                  error: 'villageHouseRequired'.tr,
                ),

                /// ========= Button =========
                SizedBox(height: 20),
                CustomButtonCommon(
                  title: 'next'.tr,
                  onpress: () {
                    if (controller.step2formKey.currentState!.validate()) {
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

  /// ---------- Helpers ----------

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

  Widget _textField({
    required String label,
    required TextEditingController controller,
    required String error,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: label, fontsize: 16),
        SizedBox(height: 4),
        CustomTextFormField(
          controller: controller,
          hint: label,
          validator: (value) => value!.isEmpty ? error : null,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

// class ProfileSetupsStepTwoScreen extends StatefulWidget {
//   ProfileSetupsStepTwoScreen({super.key});

//   @override
//   State<ProfileSetupsStepTwoScreen> createState() =>
//       _ProfileSetupsStepTwoScreenState();
// }

// class _ProfileSetupsStepTwoScreenState
//     extends State<ProfileSetupsStepTwoScreen> {
//   ProfileController controller = Get.find<ProfileController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: Get.height,
//         width: double.infinity,
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 14),
//           child: SingleChildScrollView(
//             child: Form(
//               key: controller.step2formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ///=============="Present Address================================
//                   SizedBox(height: 16),
//                   Container(
//                     height: 48,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: AppColors.primaryColor,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         "Present Address".tr,
//                         style: TextStyle(
//                           color: AppColors.whiteColor,
//                           fontSize: 24,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   CustomText(
//                     text: "Zip code".tr,
//                     fontsize: 16,
//                   ),
//                   SizedBox(height: 4),
//                   CustomTextFormField(
//                     controller: controller.presentZipCodeController.value,
//                     hint: "Zip Code".tr,
//                     validator: (value) =>
//                         value!.isEmpty ? "Zip code is required" : null,
//                   ),
//                   SizedBox(height: 16),
//                   CustomText(
//                     text: "Village/House".tr,
//                     fontsize: 16,
//                   ),
//                   SizedBox(height: 4),
//                   CustomTextFormField(
//                     controller: controller.presentVillageController.value,
//                     hint: "Village/House".tr,
//                     validator: (value) =>
//                         value!.isEmpty ? "Village/House is required" : null,
//                   ),
//                   SizedBox(height: 16),
//                   CustomText(
//                     text: "Road/Block/Section".tr,
//                     fontsize: 16,
//                   ),
//                   SizedBox(height: 4),
//                   CustomTextFormField(
//                     controller: controller.presentRoadController.value,
//                     hint: "Road/Block/Section".tr,
//                     validator: (value) => value!.isEmpty
//                         ? "Road/Block/Section is required"
//                         : null,
//                   ),

//                   // /==============Permanent Address================================

//                   Obx(
//                     () => Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CheckboxListTile(
//                           value: controller
//                               .isPresentAddressAsPermanentAddress.value,
//                           onChanged: (value) {
//                             controller.isPresentAddressAsPermanentAddress
//                                 .value = value!;

//                             if (controller
//                                 .isPresentAddressAsPermanentAddress.value) {
//                               // permanent zip code
//                               controller.permanentZipCodeController.value.text =
//                                   controller.profileModel.value.userProfile!
//                                           .permanentAddress
//                                           ?.split(',')[0] ??
//                                       "";

//                               // permanent village
//                               controller.permanentVillageController.value.text =
//                                   controller.profileModel.value.userProfile!
//                                           .permanentAddress
//                                           ?.split(',')[1] ??
//                                       "";

//                               // permanent road
//                               controller.permanentRoadController.value.text =
//                                   controller.profileModel.value.userProfile!
//                                           .permanentAddress
//                                           ?.split(',')[2] ??
//                                       "";
//                             } else {
//                               controller.permanentZipCodeController.value.text =
//                                   "";

//                               // permanent village
//                               controller.permanentVillageController.value.text =
//                                   "";

//                               // permanent road
//                               controller.permanentRoadController.value.text =
//                                   "";
//                             }
//                           },
//                           title: Text(
//                               "Mark Present Address as Permanent Address".tr),
//                         ),
//                         SizedBox(height: 16),
//                         Container(
//                           height: 48,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: AppColors.primaryColor,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text(
//                               "Permanent Address".tr,
//                               style: TextStyle(
//                                 color: AppColors.whiteColor,
//                                 fontSize: 24,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 16),
//                         CustomText(
//                           text: "Zip code".tr,
//                           fontsize: 16,
//                         ),
//                         SizedBox(height: 4),
//                         CustomTextFormField(
//                           controller:
//                               controller.permanentZipCodeController.value,
//                           hint: "Zip Code".tr,
//                           validator: (value) =>
//                               value!.isEmpty ? "Zip code is required" : null,
//                         ),
//                         SizedBox(height: 16),
//                         CustomText(
//                           text: "Village/House".tr,
//                           fontsize: 16,
//                         ),
//                         SizedBox(height: 4),
//                         CustomTextFormField(
//                           controller:
//                               controller.permanentVillageController.value,
//                           hint: "Village/House".tr,
//                           validator: (value) => value!.isEmpty
//                               ? "Village/House is required"
//                               : null,
//                         ),
//                         SizedBox(height: 16),
//                         CustomText(
//                           text: "Road/Block/Section".tr,
//                           fontsize: 16,
//                         ),
//                         SizedBox(height: 4),
//                         CustomTextFormField(
//                           controller: controller.permanentRoadController.value,
//                           hint: "Road/Block/Section".tr,
//                           validator: (value) => value!.isEmpty
//                               ? "Road/Block/Section is required"
//                               : null,
//                         ),
//                       ],
//                     ),
//                   ),

//                   // =====Overseas Address=====
//                   SizedBox(height: 16),
//                   Container(
//                     height: 48,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: AppColors.primaryColor,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         "Overseas Address".tr,
//                         style: TextStyle(
//                           color: AppColors.whiteColor,
//                           fontSize: 24,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   CustomText(
//                     text: "Country".tr,
//                     fontsize: 16,
//                   ),
//                   SizedBox(height: 4),
//                   Obx(
//                     () => CustomDropdown<CountryModel>(
//                       hint: "Select Country",
//                       items: controller.countryList,
//                       value: controller.selectedCountry.value,
//                       itemToString: (item) => item.country ?? "",
//                       onChanged: (val) =>
//                           controller.selectedCountry.value = val,
//                     ),
//                   ),

//                   SizedBox(height: 16),
//                   CustomText(
//                     text: "Village/House".tr,
//                     fontsize: 16,
//                   ),
//                   SizedBox(height: 4),
//                   CustomTextFormField(
//                     controller: controller.overseasVillageController.value,
//                     hint: "Village/House".tr,
//                     validator: (value) =>
//                         value!.isEmpty ? "Village/House is required" : null,
//                   ),

//                   ///=============Button====================
//                   SizedBox(height: 16),
//                   CustomButtonCommon(
//                     // loading: authController.loadingLoading.value == true,
//                     title: 'next'.tr,
//                     onpress: () {
//                       if (controller.step2formKey.currentState!.validate()) {
//                         controller
//                             .onStepTapped(controller.currentStep.value + 1);
//                       }
//                     },
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



