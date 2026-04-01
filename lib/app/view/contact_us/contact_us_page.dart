import 'package:al_wasyeah/app/view/contact_us/controller/contact_us_controller.dart';
import 'package:al_wasyeah/app/core/l10n/app_localizations.dart';
import 'package:al_wasyeah/app/core/utils/app_constant.dart';
import 'package:al_wasyeah/app/core/utils/app_image.dart';
import 'package:al_wasyeah/app/core/widgets/custom_button_common.dart';
import 'package:al_wasyeah/app/core/widgets/custom_text.dart';
import 'package:al_wasyeah/app/core/widgets/custom_text_field.dart';
import 'package:al_wasyeah/app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactUsPage extends GetView<ContactUsController> {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.contact_us,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Image.asset(
                  AppImages.app_logo,
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomText(
                  text: AppLocalizations.of(context)!.get_in_touch_with_us,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFormField(
                  controller: controller.nameController,
                  hint: AppLocalizations.of(context)!.first_name,
                  validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.please_enter_person_name : null,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFormField(
                  controller: controller.emailController,
                  hint: AppLocalizations.of(context)!.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.please_enter_your_email;
                    }
                    if (!AppConstants.emailValidate.hasMatch(value)) {
                      return AppLocalizations.of(context)!.invalid_email;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFormField(
                  controller: controller.phoneController,
                  hint: AppLocalizations.of(context)!.phone_number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.please_enter_your_phone_number;
                    }
                    if (!AppConstants.poneValidate.hasMatch(value)) {
                      return AppLocalizations.of(context)!.invalid_phone_number;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFormField(
                  controller: controller.messageController,
                  maxLines: 10,
                  hint: AppLocalizations.of(context)!.message,
                  validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.please_enter_message : null,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Obx(
                  () => CustomButton(
                    title: AppLocalizations.of(context)!.send,
                    loading: controller.status.value.isLoading,
                    onpress: controller.submitContactForm,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
