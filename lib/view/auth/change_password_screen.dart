import 'package:al_wasyeah/controllers/controllers.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/custom_button_common.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final TextEditingController oldPassCNRL = TextEditingController();
  final TextEditingController newPass2 = TextEditingController();
  final TextEditingController conPass3 = TextEditingController();
  final HomeController profileSetupController = Get.find<HomeController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: CustomText(
          text: AppLocalizations.of(context)!.change_password,
          fontsize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.hitTextColor000000,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.hitTextColor000000),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              CustomText(
                text: AppLocalizations.of(context)!
                    .please_enter_your_old_and_new_passwords_to_continue,
                maxline: 2,
                fontsize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                        bottomLeft: Radius.circular(24.r),
                        bottomRight: Radius.circular(24.r)),
                    color: AppColors.grey),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///============Current password=====>
                        CustomText(
                          text: AppLocalizations.of(context)!.current_password,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: CustomTextField(
                            controller: oldPassCNRL,
                            isPassword: true,
                            hintText: AppLocalizations.of(context)!.password,

                            // prefixIcon: Padding(
                            //   padding: EdgeInsets.only(left: 16.w, right: 12.w),
                            //   child: SvgPicture.asset(AppIcons.passIcon, color: AppColors.primaryColor, height: 24.h, width: 24.w),
                            // ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .please_enter_your_password;
                              } else if (value.length < 8 ||
                                  !AppConstants.validatePassword(value)) {
                                return AppLocalizations.of(context)!
                                    .password_8_characters_min_letters_digits_required;
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        ///============New password=====>

                        CustomText(
                          text: AppLocalizations.of(context)!.new_password,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: CustomTextField(
                            controller: newPass2,
                            isPassword: true,
                            hintText: AppLocalizations.of(context)!.password,
                            //
                            // prefixIcon: Padding(
                            //   padding: EdgeInsets.only(left: 16.w, right: 12.w),
                            //   child: SvgPicture.asset(AppIcons.passIcon, color: AppColors.primaryColor, height: 24.h, width: 24.w),
                            // ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .please_enter_your_password;
                              } else if (value.length < 8 ||
                                  !AppConstants.validatePassword(value)) {
                                return AppLocalizations.of(context)!
                                    .password_8_characters_min_letters_digits_required;
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        ///============Re password=====>
                        CustomText(
                          text: AppLocalizations.of(context)!
                              .re_enter_new_password,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: CustomTextField(
                            controller: conPass3,
                            isPassword: true,
                            hintText: AppLocalizations.of(context)!.password,

                            // prefixIcon: Padding(
                            //   padding: EdgeInsets.only(left: 16.w, right: 12.w),
                            //   child: SvgPicture.asset(AppIcons.passIcon, color: AppColors.primaryColor, height: 24.h, width: 24.w),
                            // ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .please_enter_your_password;
                              } else if (value != newPass2.text) {
                                return AppLocalizations.of(context)!
                                    .passwords_do_not_match;
                              }
                              return null;
                            },
                          ),
                        ),

                        // GestureDetector(
                        //     onTap: (){
                        //       Get.toNamed(AppRoutes.forgotPassScreen);
                        //     },
                        //     child: Padding(
                        //       padding:  EdgeInsets.only(left: 190.w),
                        //       child: Text(" Forgot Password",style: TextStyle(decoration: TextDecoration.underline,color: Color(0xff0C4479),
                        //           decorationColor:Color(0xff0C4479),
                        //           fontWeight: FontWeight.w500,fontSize: 14.sp),),
                        //     )),
                        // SizedBox(height: 20.h,),

                        Obx(
                          () => Padding(
                            padding: EdgeInsets.all(8.r),
                            child: CustomButtonCommon(
                              loading:
                                  profileSetupController.forPassLoading.value,
                              color: AppColors.primaryColor,
                              titlecolor: AppColors.whiteColor,
                              onpress: () {
                                if (formKey.currentState!.validate()) {
                                  profileSetupController.changePass(
                                      oldPassCNRL.text,
                                      newPass2.text,
                                      conPass3.text);
                                }
                              },
                              title:
                                  AppLocalizations.of(context)!.change_password,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
