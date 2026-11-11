import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wasiyyat/app/core/l10n/app_localizations.dart';
import 'package:wasiyyat/app/core/route/route_names.dart';
import 'package:wasiyyat/app/core/utils/app_colors.dart';
import 'package:wasiyyat/app/core/utils/app_constant.dart';
import 'package:wasiyyat/app/core/utils/app_icons.dart';
import 'package:wasiyyat/app/core/widgets/custom_button_common.dart';
import 'package:wasiyyat/app/core/widgets/custom_text.dart';
import 'package:wasiyyat/app/core/widgets/custom_text_field.dart';
import 'package:wasiyyat/app/core/widgets/exit_dialog.dart';
import 'package:wasiyyat/app/view/auth/controller/auth_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> _logKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    final List<GridItem> items = [
      GridItem(
        icon: AppIcons.propertyIcons,
        text: localization.property_distribution,
        onTap: () => Get.toNamed(
          RouteName.propertyDistributionPage,
          arguments: {"public": true},
          preventDuplicates: false,
        ),
      ),
      GridItem(
        icon: AppIcons.zakatIcons,
        text: localization.zakat_calculation,
        onTap: () {
          Get.toNamed(RouteName.zakatCalculatorPage, preventDuplicates: false);
        },
      ),
      GridItem(
        icon: AppIcons.contactIcons,
        text: localization.contact_us,
        onTap: () =>
            Get.toNamed(RouteName.contactPage, preventDuplicates: false),
      ),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return;
        await showExitConfirmationDialog(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: AutofillGroup(
              child: Form(
                key: _logKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),

                    // Logo
                    Center(
                      child: SvgPicture.asset(
                        AppIcons.logo,
                        height: 140.h,
                        width: 180.w,
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Quick Action Menu Icons
                    SizedBox(
                      height: 90.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: items.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 16.w),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return GestureDetector(
                            onTap: item.onTap,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  item.icon,
                                  height: 50.h,
                                  width: 50.w,
                                ),
                                SizedBox(height: 4.h),
                                CustomText(text: item.text),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Username / Email Field
                    CustomText(
                      text: localization.user_name,
                      color: AppColors.hitTextColor000000,
                      fontsize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: authController.userNameController,
                      hintText: localization.user_name,
                      borderColor: AppColors.secondaryPrimaryColor,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 12.w),
                        child: SvgPicture.asset(
                          AppIcons.email,
                          colorFilter: ColorFilter.mode(
                            AppColors.primaryColor,
                            BlendMode.srcIn,
                          ),
                          height: 20.h,
                          width: 20.w,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return localization.please_enter_your_email;
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 16.h),

                    // Password Field
                    CustomText(
                      text: localization.password,
                      color: AppColors.hitTextColor000000,
                      fontsize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: authController.passwordController,
                      isPassword: true,
                      hintText: localization.please_enter_your_password,
                      borderColor: AppColors.secondaryPrimaryColor,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 12.w),
                        child: SvgPicture.asset(
                          AppIcons.passIcon,
                          colorFilter: ColorFilter.mode(
                            AppColors.primaryColor,
                            BlendMode.srcIn,
                          ),
                          height: 22.h,
                          width: 22.w,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localization.please_enter_your_password;
                        } else if (value.length < 8 ||
                            !AppConstants.validatePassword(value)) {
                          return localization
                              .password_8_characters_min_letters_digits_required;
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 12.h),

                    // Forgot Password Link
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(
                            RouteName.forgotPasswordPage,
                            parameters: {
                              'email': authController.userNameController.text
                            },
                          );
                        },
                        child: CustomText(
                          text: localization.forget_password,
                          fontsize: 15.sp,
                          color: AppColors.primaryColor,
                          textAlign: TextAlign.right,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Sign In Button
                    Obx(
                      () => CustomButton(
                        loading: authController.signInLoading.value,
                        title: localization.sign_in,
                        onpress: () {
                          if (_logKey.currentState!.validate()) {
                            TextInput.finishAutofillContext();
                            authController.signInHandle(
                              userName:
                                  authController.userNameController.text.trim(),
                              password: authController.passwordController.text,
                            );
                          }
                        },
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Register Now Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: localization.don_t_have_an_account,
                          fontsize: 16.sp,
                        ),
                        SizedBox(width: 4.w),
                        InkWell(
                          onTap: () {
                            Get.toNamed(
                              RouteName.registrationPage,
                              preventDuplicates: false,
                            );
                          },
                          child: CustomText(
                            text: localization.register_now,
                            fontsize: 16.sp,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),
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
