import 'package:al_wasyeah/app/core/utils/app_colors.dart';
import 'package:al_wasyeah/app/core/widgets/custom_app_bar.dart';
import 'package:al_wasyeah/app/core/utils/app_icons.dart';
import 'package:al_wasyeah/app/core/widgets/custom_button_common.dart';
import 'package:al_wasyeah/app/core/widgets/custom_pin_text_field.dart';
import 'package:al_wasyeah/app/core/widgets/custom_text.dart';
import 'package:al_wasyeah/app/view/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/app/core/l10n/app_localizations.dart';

class OtpVerifyPage extends StatefulWidget {
  OtpVerifyPage({super.key});

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  String email = "", mobile = "";
  @override
  void initState() {
    var data = Get.arguments;
    if (data != null) {
      email = data["email"];
      mobile = data["mobile"];
    }
    super.initState();
    print("otp::::---------${email} ${mobile}");
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
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
                  textEditingController: authController.otpController,
                ),
                SizedBox(
                  height: 16.h,
                ),

                ///=============Sign In Button====================
                CustomButton(
                  // loading: authController.loadingLoading.value == true,
                  title: AppLocalizations.of(context)!.submit,
                  onpress: () {
                    authController.verifyOtp(otp: authController.otpController.text, email: email, mobile: mobile);
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
