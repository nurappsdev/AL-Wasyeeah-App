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
  ProfileSetupsStepTwoScreen({super.key});

  @override
  State<ProfileSetupsStepTwoScreen> createState() =>
      _ProfileSetupsStepTwoScreenState();
}

class _ProfileSetupsStepTwoScreenState
    extends State<ProfileSetupsStepTwoScreen> {
  ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.h),
          child: SingleChildScrollView(
            child: Form(
              key: controller.step2formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///=============="Present Address================================
                  SizedBox(height: 16.h),
                  Container(
                    height: 48.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0.h),
                      child: Text(
                        "Present Address".tr,
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 24.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  CustomText(
                    text: "Zip code".tr,
                    fontsize: 16.sp,
                  ),
                  SizedBox(height: 4.h),
                  CustomTextFormField(
                    controller: controller.presentZipCodeController.value,
                    hint: "Zip Code".tr,
                    validator: (value) =>
                        value!.isEmpty ? "Zip code is required" : null,
                  ),
                  SizedBox(height: 16.h),
                  CustomText(
                    text: "Village/House".tr,
                    fontsize: 16.sp,
                  ),
                  SizedBox(height: 4.h),
                  CustomTextFormField(
                    controller: controller.presentVillageController.value,
                    hint: "Village/House".tr,
                    validator: (value) =>
                        value!.isEmpty ? "Village/House is required" : null,
                  ),
                  SizedBox(height: 16.h),
                  CustomText(
                    text: "Road/Block/Section".tr,
                    fontsize: 16.sp,
                  ),
                  SizedBox(height: 4.h),
                  CustomTextFormField(
                    controller: controller.presentRoadController.value,
                    hint: "Road/Block/Section".tr,
                    validator: (value) => value!.isEmpty
                        ? "Road/Block/Section is required"
                        : null,
                  ),

                  // /==============Permanent Address================================
                  Obx(
                    () => CheckboxListTile(
                      value:
                          controller.isPresentAddressAsPermanentAddress.value,
                      onChanged: (value) {
                        controller.isPresentAddressAsPermanentAddress.value =
                            value!;
                      },
                      title:
                          Text("Mark Present Address as Permanent Address".tr),
                    ),
                  ),

                  Obx(
                    () => !controller.isPresentAddressAsPermanentAddress.value
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              SizedBox(height: 16.h),
                              Container(
                                height: 48.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0.h),
                                  child: Text(
                                    "Permanent Address".tr,
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              CustomText(
                                text: "Zip code".tr,
                                fontsize: 16.sp,
                              ),
                              SizedBox(height: 4.h),
                              CustomTextFormField(
                                controller:
                                    controller.permanentZipCodeController.value,
                                hint: "Zip Code".tr,
                                validator: (value) => value!.isEmpty
                                    ? "Zip code is required"
                                    : null,
                              ),
                              SizedBox(height: 16.h),
                              CustomText(
                                text: "Village/House".tr,
                                fontsize: 16.sp,
                              ),
                              SizedBox(height: 4.h),
                              CustomTextFormField(
                                controller:
                                    controller.permanentVillageController.value,
                                hint: "Village/House".tr,
                                validator: (value) => value!.isEmpty
                                    ? "Village/House is required"
                                    : null,
                              ),
                              SizedBox(height: 16.h),
                              CustomText(
                                text: "Road/Block/Section".tr,
                                fontsize: 16.sp,
                              ),
                              SizedBox(height: 4.h),
                              CustomTextFormField(
                                controller:
                                    controller.permanentRoadController.value,
                                hint: "Road/Block/Section".tr,
                                validator: (value) => value!.isEmpty
                                    ? "Road/Block/Section is required"
                                    : null,
                              ),
                            ],
                          ),
                  ),

                  // =====Overseas Address=====
                  SizedBox(height: 16.h),
                  Container(
                    height: 48.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0.h),
                      child: Text(
                        "Overseas Address".tr,
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 24.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  CustomText(
                    text: "Country".tr,
                    fontsize: 16.sp,
                  ),
                  SizedBox(height: 4.h),
                  Obx(
                    () => CustomDropdown<CountryModel>(
                      hint: "Select Country",
                      items: controller.countryList,
                      value: controller.selectedCountry.value,
                      itemToString: (item) => item.country ?? "",
                      onChanged: (val) =>
                          controller.selectedCountry.value = val,
                    ),
                  ),

                  SizedBox(height: 16.h),
                  CustomText(
                    text: "Village/House".tr,
                    fontsize: 16.sp,
                  ),
                  SizedBox(height: 4.h),
                  CustomTextFormField(
                    controller: controller.overseasVillageController.value,
                    hint: "Village/House".tr,
                    validator: (value) =>
                        value!.isEmpty ? "Village/House is required" : null,
                  ),

                  ///=============Button====================
                  SizedBox(height: 16.h),
                  CustomButtonCommon(
                    // loading: authController.loadingLoading.value == true,
                    title: "Next".tr,
                    onpress: () {
                      if (controller.step2formKey.currentState!.validate()) {
                        controller
                            .onStepTapped(controller.currentStep.value + 1);
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
