import 'package:al_wasyeah/controllers/profile/address_form.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class ProfileSetupsStepTwoScreen extends StatefulWidget {
  const ProfileSetupsStepTwoScreen({super.key});

  @override
  State<ProfileSetupsStepTwoScreen> createState() =>
      _ProfileSetupsStepTwoScreenState();
}

class _ProfileSetupsStepTwoScreenState
    extends State<ProfileSetupsStepTwoScreen> {
  final ProfileController controller = Get.find<ProfileController>();

  AddressForm get form => controller.addressForm.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.h),
        child: SingleChildScrollView(
          child: Form(
            key: controller.step2formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),

                /// ========= Present Address =========
                _sectionTitle("Present Address"),

                _textField(
                  label: "Zip code",
                  controller: form.presentZipCode,
                ),
                _textField(
                  label: "Village/House",
                  controller: form.presentVillage,
                ),
                _textField(
                  label: "Road/Block/Section",
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
                        "Mark Present Address as Permanent Address".tr,
                      ),
                    )),

                _sectionTitle("Permanent Address"),

                _textField(
                  label: "Zip code",
                  controller: form.permanentZipCode,
                ),
                _textField(
                  label: "Village/House",
                  controller: form.permanentVillage,
                ),
                _textField(
                  label: "Road/Block/Section",
                  controller: form.permanentRoad,
                ),

                /// ========= Overseas Address =========
                _sectionTitle("Overseas Address"),

                Obx(() => CustomDropdown<CountryModel>(
                      hint: "Select Country",
                      items: controller.countryList,
                      value: form.selectedOverseasCountry.value,
                      itemToString: (item) => item.country ?? "",
                      onChanged: (val) =>
                          form.selectedOverseasCountry.value = val,
                    )),

                _textField(
                  label: "Village/House",
                  controller: form.overseasVillage,
                ),

                /// ========= Button =========
                SizedBox(height: 20.h),
                CustomButtonCommon(
                  title: "Next".tr,
                  onpress: () {
                    if (controller.step2formKey.currentState!.validate()) {
                      controller.onStepTapped(controller.currentStep.value + 1);
                    }
                  },
                ),
                SizedBox(height: 20.h),
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
        SizedBox(height: 16.h),
        Container(
          height: 48.h,
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
  }) {
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
//           padding: EdgeInsets.symmetric(horizontal: 14.h),
//           child: SingleChildScrollView(
//             child: Form(
//               key: controller.step2formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ///=============="Present Address================================
//                   SizedBox(height: 16.h),
//                   Container(
//                     height: 48.h,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: AppColors.primaryColor,
//                       borderRadius: BorderRadius.circular(8.r),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0.h),
//                       child: Text(
//                         "Present Address".tr,
//                         style: TextStyle(
//                           color: AppColors.whiteColor,
//                           fontSize: 24.sp,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16.h),
//                   CustomText(
//                     text: "Zip code".tr,
//                     fontsize: 16.sp,
//                   ),
//                   SizedBox(height: 4.h),
//                   CustomTextFormField(
//                     controller: controller.presentZipCodeController.value,
//                     hint: "Zip Code".tr,
//                     validator: (value) =>
//                         value!.isEmpty ? "Zip code is required" : null,
//                   ),
//                   SizedBox(height: 16.h),
//                   CustomText(
//                     text: "Village/House".tr,
//                     fontsize: 16.sp,
//                   ),
//                   SizedBox(height: 4.h),
//                   CustomTextFormField(
//                     controller: controller.presentVillageController.value,
//                     hint: "Village/House".tr,
//                     validator: (value) =>
//                         value!.isEmpty ? "Village/House is required" : null,
//                   ),
//                   SizedBox(height: 16.h),
//                   CustomText(
//                     text: "Road/Block/Section".tr,
//                     fontsize: 16.sp,
//                   ),
//                   SizedBox(height: 4.h),
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
//                         SizedBox(height: 16.h),
//                         Container(
//                           height: 48.h,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: AppColors.primaryColor,
//                             borderRadius: BorderRadius.circular(8.r),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.all(8.0.h),
//                             child: Text(
//                               "Permanent Address".tr,
//                               style: TextStyle(
//                                 color: AppColors.whiteColor,
//                                 fontSize: 24.sp,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 16.h),
//                         CustomText(
//                           text: "Zip code".tr,
//                           fontsize: 16.sp,
//                         ),
//                         SizedBox(height: 4.h),
//                         CustomTextFormField(
//                           controller:
//                               controller.permanentZipCodeController.value,
//                           hint: "Zip Code".tr,
//                           validator: (value) =>
//                               value!.isEmpty ? "Zip code is required" : null,
//                         ),
//                         SizedBox(height: 16.h),
//                         CustomText(
//                           text: "Village/House".tr,
//                           fontsize: 16.sp,
//                         ),
//                         SizedBox(height: 4.h),
//                         CustomTextFormField(
//                           controller:
//                               controller.permanentVillageController.value,
//                           hint: "Village/House".tr,
//                           validator: (value) => value!.isEmpty
//                               ? "Village/House is required"
//                               : null,
//                         ),
//                         SizedBox(height: 16.h),
//                         CustomText(
//                           text: "Road/Block/Section".tr,
//                           fontsize: 16.sp,
//                         ),
//                         SizedBox(height: 4.h),
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
//                   SizedBox(height: 16.h),
//                   Container(
//                     height: 48.h,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: AppColors.primaryColor,
//                       borderRadius: BorderRadius.circular(8.r),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0.h),
//                       child: Text(
//                         "Overseas Address".tr,
//                         style: TextStyle(
//                           color: AppColors.whiteColor,
//                           fontSize: 24.sp,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16.h),
//                   CustomText(
//                     text: "Country".tr,
//                     fontsize: 16.sp,
//                   ),
//                   SizedBox(height: 4.h),
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

//                   SizedBox(height: 16.h),
//                   CustomText(
//                     text: "Village/House".tr,
//                     fontsize: 16.sp,
//                   ),
//                   SizedBox(height: 4.h),
//                   CustomTextFormField(
//                     controller: controller.overseasVillageController.value,
//                     hint: "Village/House".tr,
//                     validator: (value) =>
//                         value!.isEmpty ? "Village/House is required" : null,
//                   ),

//                   ///=============Button====================
//                   SizedBox(height: 16.h),
//                   CustomButtonCommon(
//                     // loading: authController.loadingLoading.value == true,
//                     title: "Next".tr,
//                     onpress: () {
//                       if (controller.step2formKey.currentState!.validate()) {
//                         controller
//                             .onStepTapped(controller.currentStep.value + 1);
//                       }
//                     },
//                   ),
//                   SizedBox(
//                     height: 20.h,
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
