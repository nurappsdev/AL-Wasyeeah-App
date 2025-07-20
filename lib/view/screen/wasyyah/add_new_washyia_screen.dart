
import 'package:al_wasyeah/view/screen/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../../utils/utils.dart';
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
          text: "Add more content".tr,
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
                    text: "add your washiya content title".tr,
                    color: AppColors.hitTextColor000000,
                    fontsize: 16.sp,
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller: contentController,
                      hintText: "add your washiya content title".tr,
                      maxLine: 1,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'add your washiya content title'.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  // Note section
                  SizedBox(height: 16.h),
                  CustomText(
                    text: "add your washiya content".tr,
                    color: AppColors.hitTextColor000000,
                    fontsize: 16.sp,
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller: titleController,
                      hintText: "add your washiya content".tr,
                      maxLine: 10,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'add your washiya content'.tr;
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
                          title: "Cancel".tr,
                          onpress: () {},
                          width: 100.w,
                          height: 40.h,
                          color: Colors.red,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(()=>
                           CustomButton(
                             loading: wasyyahController.addWaseeyea.value ==true,
                            title: "Save".tr,
                            onpress: () {
                               if(_createWasKey.currentState!.validate()){
                                 wasyyahController.addWasyyahData(
                                     title: titleController.text,
                                     content: contentController.text
                                 );

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
