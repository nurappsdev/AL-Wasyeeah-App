import 'package:al_wasyeah/core/utils/app_colors.dart';
import 'package:al_wasyeah/app/view/widgets/custom_app_bar.dart';
import 'package:al_wasyeah/core/utils/app_icons.dart';
import 'package:al_wasyeah/app/view/profile/profile_page.dart';
import 'package:al_wasyeah/core/widgets/custom_button_common.dart';
import 'package:al_wasyeah/core/widgets/custom_pin_text_field.dart';
import 'package:al_wasyeah/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/core/l10n/app_localizations.dart';

class OtpVerifyScreen extends StatelessWidget {
  OtpVerifyScreen({super.key});
  final TextEditingController picController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.otp_verify,
      ),
      body: Container(
        width: double.infinity,
        height: Get.height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Center(child: SvgPicture.asset(AppIcons.otpIcon, height: 270.h, width: double.infinity)),
                SizedBox(
                  height: 16.h,
                ),
                Center(
                    child: CustomText(
                  text: AppLocalizations.of(context)!.enter_otp,
                  fontsize: 24.sp,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                )),
                SizedBox(
                  height: 16.h,
                ),
                Center(
                    child: CustomText(
                  text: AppLocalizations.of(context)!.an_5_digit_code_sent_to_your,
                  fontsize: 16.sp,
                  maxline: 2,
                  textAlign: TextAlign.center,
                )),
                SizedBox(
                  height: 16.h,
                ),
                CustomPinCodeTextField(
                  textEditingController: picController,
                ),
                SizedBox(
                  height: 16.h,
                ),

                ///=============Sign In Button====================
                CustomButton(
                  // loading: authController.loadingLoading.value == true,
                  title: AppLocalizations.of(context)!.submit,
                  onpress: () {
                    Get.off(() => ProfilePage());
                    // if (_forRegKey.currentState!.validate()) {
                    //   // authController.loginHandle(
                    //   //     emailController.text, passController.text);
                    // }
                  },
                ),
                SizedBox(
                  height: 14.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: AppLocalizations.of(context)!.didn_t_receive_code,
                      fontsize: 18.sp,
                    ),
                    CustomText(
                      text: AppLocalizations.of(context)!.resent_code,
                      fontsize: 18.sp,
                      color: AppColors.primaryColor,
                    ),
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
