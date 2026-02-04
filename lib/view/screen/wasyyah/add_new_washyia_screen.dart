import 'package:al_wasyeah/view/screen/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_en_strings.dart';
import '../../widgets/widgets.dart';

class AddNewWashyiaScreen extends StatefulWidget {
  AddNewWashyiaScreen({super.key});

  @override
  State<AddNewWashyiaScreen> createState() => _AddNewWashyiaScreenState();
}

class _AddNewWashyiaScreenState extends State<AddNewWashyiaScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController contentController = TextEditingController();

  WasyyahController wasyyahController = Get.put(WasyyahController());

  final GlobalKey<FormState> _createWasKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppString.addMoreContent.tr,
          fontsize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SizedBox(
        height: Get.height,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Form(
              key: _createWasKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Note section
                  SizedBox(height: 16.h),
                  CustomText(
                    text: AppString.addWashiyaTitleHint.tr,
                    color: AppColors.hitTextColor000000,
                    fontsize: 16.sp,
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller: titleController,
                      hintText: AppString.addWashiyaTitleHint.tr,
                      maxLine: 1,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppString.enterWasyyaTitleError.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  // Note section
                  SizedBox(height: 16.h),
                  CustomText(
                    text: AppString.addWashiyaContentHint.tr,
                    color: AppColors.hitTextColor000000,
                    fontsize: 16.sp,
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller: contentController,
                      hintText: AppString.addWashiyaContentHint.tr,
                      maxLine: 10,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppString.enterWasyyaContentError.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 120.h), // Replaces Spacer

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                          title: AppString.cancel.tr,
                          onpress: () {},
                          width: 100.w,
                          height: 40.h,
                          color: Colors.red,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                          () => CustomButton(
                            loading:
                                wasyyahController.addWaseeyea.value == true,
                            title: AppString.save.tr,
                            onpress: () {
                              if (_createWasKey.currentState!.validate()) {
                                wasyyahController.addWasyyahData(
                                    title: titleController.text,
                                    content: contentController.text);
                              }
                            },
                            width: 100.w,
                            height: 40.h,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
