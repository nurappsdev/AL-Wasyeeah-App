import 'package:al_wasyeah/view/screen/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/widgets.dart';

class AddNewWashyiaScreen extends StatefulWidget {
  AddNewWashyiaScreen({super.key});

  @override
  State<AddNewWashyiaScreen> createState() => _AddNewWashyiaScreenState();
}

class _AddNewWashyiaScreenState extends State<AddNewWashyiaScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController contentController = TextEditingController();

  WasyyahController wasyyahController = Get.find<WasyyahController>();

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
          text: 'addMoreContent'.tr,
          fontsize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SizedBox(
        height: Get.height,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _createWasKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Note section
                  SizedBox(height: 16),
                  CustomText(
                    text: 'addWashiyaTitleHint'.tr,
                    color: AppColors.hitTextColor000000,
                    fontsize: 16,
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: CustomTextField(
                      controller: titleController,
                      hintText: 'addWashiyaTitleHint'.tr,
                      maxLine: 1,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enterWasyyaTitleError'.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  // Note section
                  SizedBox(height: 16),
                  CustomText(
                    text: 'addWashiyaContentHint'.tr,
                    color: AppColors.hitTextColor000000,
                    fontsize: 16,
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: CustomTextField(
                      controller: contentController,
                      hintText: 'addWashiyaContentHint'.tr,
                      maxLine: 10,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enterWasyyaContentError'.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 120), // Replaces Spacer

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                          title: 'cancel'.tr,
                          onpress: () {},
                          width: 100,
                          height: 40,
                          color: Colors.red,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                          () => CustomButton(
                            loading:
                                wasyyahController.addWaseeyea.value == true,
                            title: 'save'.tr,
                            onpress: () {
                              if (_createWasKey.currentState!.validate()) {
                                wasyyahController.addWasyyahData(
                                    title: titleController.text,
                                    content: contentController.text);
                              }
                            },
                            width: 100,
                            height: 40,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
