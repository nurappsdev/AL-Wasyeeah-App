import 'package:al_wasyeah/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../../widgets/file_choose_and_download_button.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/gender_list_model.dart';
import 'package:al_wasyeah/controllers/profile/profile_enum.dart';

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
                            onPickFile: () => profileController.pickSpouseFile(
                                form,
                                type: ProfilePickerType.spouseNidOrPassport),
                            onDownload: () => profileController
                                .downloadSpouseFile(form,
                                    type: ProfileDownloadType
                                        .spouseNidOrPassport),
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

                // ===== Children Information =====
                SizedBox(height: 20.h),
                Center(
                  child: CustomText(
                    text: "Children's Information".tr,
                    fontsize: 20,
                  ),
                ),
                SizedBox(height: 20.h),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: profileController.childrenList.length,
                  itemBuilder: (context, index) {
                    final form = profileController.childrenList[index];
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
                            text: "Child Name".tr,
                            fontsize: 16.sp,
                          ),
                          SizedBox(height: 10.h),
                          CustomTextField(controller: form.name),
                          SizedBox(height: 20.h),
                          // Gender
                          CustomDropdown<GenderModel>(
                            hint: "Gender".tr,
                            items: profileController.genderList,
                            value: form.gender.value,
                            itemToString: (e) => e.gender ?? "",
                            onChanged: (v) => form.gender.value = v,
                          ),
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
                            onPickFile: () => profileController.pickChildFile(
                                form,
                                type: ProfilePickerType.childNidOrPassport),
                            onDownload: () => profileController
                                .downloadChildFile(form,
                                    type:
                                        ProfileDownloadType.childNidOrPassport),
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
                                    profileController.removeChild(index),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),

                // ===== Add More Child Button =====
                Padding(
                  padding: EdgeInsets.only(left: 50.w, right: 10, bottom: 10.h),
                  child: CustomButton(
                    title: "+ Add More Child".tr,
                    titlecolor: AppColors.primaryColor,
                    onpress: profileController.addChild,
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
