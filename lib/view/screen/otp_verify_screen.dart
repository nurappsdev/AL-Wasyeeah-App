import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/app_dimentions.dart';
import '../../utils/app_icons.dart';
import '../../utils/app_colors.dart';
import '../widgets/widgets.dart';
import 'profile/profile_page.dart';

class OtpVerifyScreen extends StatelessWidget {
  OtpVerifyScreen({super.key});
  TextEditingController picController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'oTPVerify'.tr,
          fontsize: 18,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: Get.height,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                Center(
                    child: SvgPicture.asset(AppIcons.otpIcon,
                        height: 270, width: double.infinity)),
                SizedBox(
                  height: 16,
                ),
                Center(
                    child: CustomText(
                  text: 'enterOTP'.tr,
                  fontsize: 24,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                )),
                SizedBox(
                  height: 16,
                ),
                Center(
                    child: CustomText(
                  text: 'otpSentMsg'.tr,
                  fontsize: 16,
                  maxline: 2,
                  textAlign: TextAlign.center,
                )),
                SizedBox(
                  height: 16,
                ),
                CustomPinCodeTextField(
                  textEditingController: picController,
                ),
                SizedBox(
                  height: 16,
                ),

                ///=============Sign In Button====================
                CustomButtonCommon(
                  // loading: authController.loadingLoading.value == true,
                  title: 'submit'.tr,
                  onpress: () {
                    Get.off(() => ProfilePage());
                    // if (_forRegKey.currentState!.validate()) {
                    //   // authController.loginHandle(
                    //   //     emailController.text, passController.text);
                    // }
                  },
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: 'didntReceiveCode'.tr,
                      fontsize: 18,
                    ),
                    CustomText(
                      text: 'resendCode'.tr,
                      fontsize: 18,
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


