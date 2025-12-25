import 'dart:io';

import 'package:al_wasyeah/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/models.dart';
import '../../../utils/utils.dart';
import '../../widgets/custom_text_field_without_border.dart';
import '../../widgets/widgets.dart';
import '../../widgets/file_choose_and_download_button.dart';

import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/controllers/profile/spouse_form.dart';

class FamilyInfoScreen extends StatelessWidget {
  FamilyInfoScreen({super.key});

  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== Header =====
          Center(
            child: CustomText(
              text: "Family Information".tr,
              fontsize: 20,
            ),
          ),
          SizedBox(height: 20.h),

          // ===== Other widgets/fields =====
          CustomText(text: "Some other field above spouses".tr),
          SizedBox(height: 10.h),
          CustomTextField(
            hintText: "Other field input",
            controller: TextEditingController(),
          ),
          SizedBox(height: 20.h),

          // ===== Spouse forms =====
          Obx(() {
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: profileController.spouseList.length,
                  itemBuilder: (context, index) {
                    final form = profileController.spouseList[index];
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
                          SizedBox(height: 10.h),
                          CustomTextField(controller: form.name),
                          SizedBox(height: 20.h),
                          CustomDropdown<ProfessionModel>(
                            hint: "Profession".tr,
                            items: profileController.professionList,
                            value: form.profession.value,
                            itemToString: (e) => e.profession ?? "",
                            onChanged: (v) => form.profession.value = v,
                          ),
                          SizedBox(height: 20.h),
                          CustomDropdown<CountryModel>(
                            hint: "Nationality".tr,
                            items: profileController.countryList,
                            value: form.nationality.value,
                            itemToString: (e) => e.country ?? "",
                            onChanged: (v) => form.nationality.value = v,
                          ),
                          SizedBox(height: 20.h),
                          CustomTextField(
                            controller: form.nid,
                            hintText: "NID/Passport No".tr,
                          ),
                          FileChooseAndDownloadButton(
                            pickedFile: form.selectedNidFile,
                            isDownloading: form.isDownloadingNid,
                            progress: form.nidDownloadProgress,
                            onPickFile: () => profileController
                                .pickSpouseFile(form, isNid: true),
                            onDownload: () => profileController
                                .downloadSpouseFile(form, isNid: true),
                            fileUrl: form.nidUrl,
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
                          if (index != 0)
                            Center(
                              child: IconButton(
                                icon: const Icon(Icons.delete_forever,
                                    color: Colors.red),
                                onPressed: () =>
                                    profileController.removeSpouse(index),
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
                    onpress: profileController.addSpouse,
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

// SpouseItemS class removed

// import 'package:al_wasyeah/controllers/profile/profile_controller.dart';
// import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
// import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
// import 'package:al_wasyeah/utils/app_colors.dart';
// import 'package:al_wasyeah/view/widgets/custom_button.dart';
// import 'package:al_wasyeah/view/widgets/custom_dropdown.dart';
// import 'package:al_wasyeah/view/widgets/custom_text.dart';
// import 'package:al_wasyeah/view/widgets/custom_text_field.dart';
// import 'package:al_wasyeah/view/widgets/file_choose_and_download_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class FamilyInfoScreen extends StatelessWidget {
//   FamilyInfoScreen({super.key});

//   final ProfileController controller = Get.find<ProfileController>();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => ListView.builder(
//         padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 20.h),
//         itemCount: controller.spouseList.length + 1, // +1 for "Add More" button
//         itemBuilder: (context, index) {
//           if (index == controller.spouseList.length) {
//             // Add More button
//             return Padding(
//               padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 50.w),
//               child: CustomButton(
//                 title: "+ Add More spouse",
//                 titlecolor: AppColors.primaryColor,
//                 onpress: controller.addSpouse,
//               ),
//             );
//           }

//           final form = controller.spouseList[index];

//           return Container(
//             key: ValueKey(form.hashCode),
//             margin: EdgeInsets.only(bottom: 24.h),
//             padding: EdgeInsets.all(16.h),
//             decoration: BoxDecoration(
//               color: AppColors.whiteColor,
//               borderRadius: BorderRadius.circular(24.r),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Spouse Name
//                 CustomText(text: "Spouse Name".tr, fontsize: 16.sp),
//                 SizedBox(height: 10.h),
//                 CustomTextField(
//                     controller: form.name, hintText: "Spouse Name".tr),
//                 SizedBox(height: 20.h),

//                 // Profession
//                 CustomDropdown<ProfessionModel>(
//                   hint: "Profession".tr,
//                   items: controller.professionList,
//                   value: form.profession.value,
//                   itemToString: (e) => e.profession ?? "",
//                   onChanged: (val) => form.profession.value = val,
//                 ),
//                 SizedBox(height: 20.h),

//                 // Nationality
//                 CustomDropdown<CountryModel>(
//                   hint: "Nationality".tr,
//                   items: controller.countryList,
//                   value: form.nationality.value,
//                   itemToString: (e) => e.country ?? "",
//                   onChanged: (val) => form.nationality.value = val,
//                 ),
//                 SizedBox(height: 20.h),

//                 // NID / Passport
//                 // Row(
//                 //   children: [
//                 //     Expanded(
//                 //       child: CustomTextField(
//                 //         controller: form.nid,
//                 //         hintText: "NID/Passport No".tr,
//                 //       ),
//                 //     ),
//                 //     SizedBox(width: 6.w),
//                 //     FileChooseAndDownloadButton(
//                 //       pickedFile: form.selectedNidFile,
//                 //       isDownloading: form.isDownloadingNid,
//                 //       progress: form.nidDownloadProgress,
//                 //       onPickFile: () =>
//                 //           controller.pickSpouseFile(form, isNid: true),
//                 //       onDownload: () =>
//                 //           controller.downloadSpouseFile(form, isNid: true),
//                 //       fileUrl: form.nidUrl,
//                 //     ),
//                 //   ],
//                 // ),

//                 SizedBox(height: 20.h),

//                 // Mobile
//                 CustomTextField(controller: form.mobile, hintText: "Mobile".tr),
//                 SizedBox(height: 16.h),

//                 // Email
//                 CustomTextField(controller: form.email, hintText: "Email".tr),
//                 SizedBox(height: 16.h),

//                 // Alive / Dead
//                 Center(
//                   child: Obx(
//                     () => ToggleButtons(
//                       isSelected: [form.isAlive.value, !form.isAlive.value],
//                       onPressed: (i) => form.isAlive.value = i == 0,
//                       borderRadius: BorderRadius.circular(8),
//                       fillColor: form.isAlive.value ? Colors.green : Colors.red,
//                       selectedColor: Colors.white,
//                       children: const [
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 40),
//                           child: Text("Alive"),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 40),
//                           child: Text("Dead"),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // Delete button (except first spouse)
//                 if (index != 0)
//                   Align(
//                     alignment: Alignment.center,
//                     child: IconButton(
//                       icon: const Icon(Icons.delete_forever, color: Colors.red),
//                       onPressed: () => controller.removeSpouse(index),
//                     ),
//                   ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
