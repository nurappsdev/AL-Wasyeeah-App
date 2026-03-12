import 'package:al_wasyeah/view/widgets/custom_button.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:al_wasyeah/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../../models/models.dart';
import '../../../utils/utils.dart';

import 'package:al_wasyeah/l10n/app_localizations.dart';

class WasiyahEditScreen extends StatefulWidget {
  WasiyahEditScreen({super.key});

  @override
  State<WasiyahEditScreen> createState() => _WasiyahEditScreenState();
}

class _WasiyahEditScreenState extends State<WasiyahEditScreen> {
  GetWasyyahResponseModel waseeyaResponseModel =
      Get.arguments as GetWasyyahResponseModel;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      if (waseeyaResponseModel != null) {
        titleController.text = waseeyaResponseModel.title ?? "";
        contentController.text = waseeyaResponseModel.content ?? "";
      }
    });
    super.initState();
  }

  WasyyahController wasyyahController = Get.put(WasyyahController());
  @override
  Widget build(BuildContext context) {
    print(titleController.text);
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppLocalizations.of(context)!.wasyyah_edit,
          fontsize: 18.sp,
        ),
      ),
      body: Container(
        height: Get.height,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: CustomTextField(
                    controller: titleController,
                    hintText: AppLocalizations.of(context)!.user_name,
                    borderColor: AppColors.secondaryPrimaryColor,
                    maxLine: 2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!
                            .please_enter_your_user_name;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: CustomTextField(
                    controller: contentController,
                    hintText: AppLocalizations.of(context)!.user_name,
                    borderColor: AppColors.secondaryPrimaryColor,
                    maxLine: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!
                            .please_enter_your_user_name;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 60.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        title: AppLocalizations.of(context)!.cancel,
                        onpress: () {
                          Get.back();
                        },
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
                              wasyyahController.isUpdateWasseya.value == true,
                          title: AppLocalizations.of(context)!.save,
                          onpress: () {
                            wasyyahController.updateWasyyahData(
                                orderSeq:
                                    waseeyaResponseModel.orderSeq!.toInt(),
                                visible:
                                    waseeyaResponseModel.visible.toString(),
                                title: titleController.text.toString(),
                                requestKey:
                                    waseeyaResponseModel.requestKey.toString(),
                                content: contentController.text);
                          },
                          width: 100.w,
                          height: 40.h,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
