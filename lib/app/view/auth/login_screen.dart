import 'package:al_wasyeah/app/controllers/auths/auth_controller.dart';
import 'package:al_wasyeah/core/services/app_routes.dart';
import 'package:al_wasyeah/core/utils/app_colors.dart';
import 'package:al_wasyeah/core/utils/app_constant.dart';
import 'package:al_wasyeah/core/utils/app_icons.dart';
import 'package:al_wasyeah/core/widgets/custom_button_common.dart';
import 'package:al_wasyeah/core/widgets/custom_text.dart';
import 'package:al_wasyeah/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:al_wasyeah/core/l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController(/*text: "WASY100008"*/);
  final TextEditingController passController = TextEditingController(/*text: "+oGq#rH^"*/);
  final AuthController authController = Get.put(AuthController());

  final GlobalKey<FormState> _logKey = GlobalKey<FormState>();
  final List<GridItem> items = [
    // GridItem(
    //   icon: AppIcons.profileIcon,
    //   text: AppLocalizations.of(context)!.nominee_log_in,
    //   onTap: null,
    // ),
    GridItem(
      icon: AppIcons.propertyIcons,
      text: AppLocalizations.of(Get.context!)!.property_distribution,
      onTap: () => Get.toNamed(AppRoutes.propertyDistributionPage, arguments: {"public": true}, preventDuplicates: false),
    ),
    GridItem(
      icon: AppIcons.zakatIcons,
      text: AppLocalizations.of(Get.context!)!.zakat_calculation,
      onTap: () {
        Get.toNamed(AppRoutes.zakatCalculatorPage, preventDuplicates: false);
      },
    ),
    GridItem(
      icon: AppIcons.contactIcons,
      text: AppLocalizations.of(Get.context!)!.contact_us,
      onTap: () => Get.toNamed(AppRoutes.contactPage, preventDuplicates: false),
    ),
    // GridItem(
    //   icon: AppIcons.helpsIcons,
    //   text: AppLocalizations.of(Get.context!)!.helps,
    //   onTap: () {
    //     //  Get.toNamed(AppRoutes.zakatCalculatorScreen, preventDuplicates: false);
    //   },
    // ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Form(
                key: _logKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80.h,
                    ),
                    Center(child: SvgPicture.asset(AppIcons.logo, height: 160.h, width: 200.w)),
                    SizedBox(
                      height: 24.h,
                    ),

                    ///================3 Icon ==== Nominee === Finance === Application=================
                    SizedBox(
                      width: double.infinity,
                      height: 120.h, // Increased height to accommodate content
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal, // Enables horizontal scrolling
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, // Only one row
                          mainAxisSpacing: 4, // Spacing between items horizontally
                          childAspectRatio: 1 / 1.1, // Aspect ratio for each item
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return GestureDetector(
                            onTap: item.onTap,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(item.icon, height: 60.h, width: 60.w),
                                SizedBox(height: 4.h),
                                CustomText(text: item.text),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    ///=============Email====================
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomText(
                      text: AppLocalizations.of(context)!.user_name,
                      color: AppColors.hitTextColor000000,
                      fontsize: 20.sp,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomTextField(
                        controller: emailController,
                        hintText: AppLocalizations.of(context)!.user_name,
                        borderColor: AppColors.secondaryPrimaryColor,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 16.w, right: 12.w),
                          child: SvgPicture.asset(AppIcons.email, color: AppColors.primaryColor, height: 20.h, width: 20.w),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.please_enter_your_email;
                          }
                          if (!!AppConstants.emailValidate.hasMatch(value)) {
                            return AppLocalizations.of(context)!.invalid_email;
                          }
                          return null;
                        },
                      ),
                    ),

                    ///=============Password====================
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomText(
                      text: AppLocalizations.of(context)!.password,
                      color: AppColors.hitTextColor000000,
                      fontsize: 20.sp,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomTextField(
                        controller: passController,
                        isPassword: true,
                        hintText: AppLocalizations.of(context)!.please_enter_your_password,
                        borderColor: AppColors.secondaryPrimaryColor,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 16.w, right: 12.w),
                          child: SvgPicture.asset(AppIcons.passIcon, color: AppColors.primaryColor, height: 24.h, width: 24.w),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.please_enter_your_password;
                          } else if (value.length < 8 || !AppConstants.validatePassword(value)) {
                            return AppLocalizations.of(context)!.password_8_characters_min_letters_digits_required;
                          }
                          return null;
                        },
                      ),
                    ),

                    ///=============Forgot====================
                    InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.forgotPasswordPage, parameters: {'email': emailController.text});
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 190.w),
                          child: CustomText(
                            text: AppLocalizations.of(context)!.forget_password,
                            fontsize: 16.sp,
                            color: AppColors.primaryColor,
                            textAlign: TextAlign.right,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                    SizedBox(
                      height: 20.h,
                    ),

                    ///=============Sign In Button====================
                    Obx(
                      () => CustomButton(
                        loading: authController.signInLoading.value == true,
                        title: AppLocalizations.of(context)!.sign_in,
                        onpress: () {
                          if (_logKey.currentState!.validate()) {
                            TextInput.finishAutofillContext();
                            authController.signInHandle(userName: emailController.text, password: passController.text);

                            //  Get.toNamed(AppRoutes.homeScreen,preventDuplicates: false);
                          }
                        },
                      ),
                    ),

                    ///=============SignUp====================
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              //  Get.toNamed(AppRoutes.otpVirifyScreen,preventDuplicates: false);
                            },
                            child: CustomText(
                              text: AppLocalizations.of(context)!.don_t_have_an_account,
                              fontsize: 20.sp,
                            )),
                        InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.registrationPage, preventDuplicates: false);
                            },
                            child: CustomText(
                              text: AppLocalizations.of(context)!.register_now,
                              fontsize: 20.sp,
                              color: AppColors.primaryColor,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GridItem {
  final String icon;
  final String text;
  final VoidCallback? onTap;

  GridItem({required this.icon, required this.text, this.onTap});
}
