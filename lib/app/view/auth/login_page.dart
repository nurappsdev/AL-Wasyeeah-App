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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
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
                    Center(
                        child: SvgPicture.asset(AppIcons.logo,
                            height: 160.h, width: 200.w)),
                    SizedBox(
                      height: 24.h,
                    ),

                    ///================3 Icon ==== Nominee === Finance === Application=================
                    SizedBox(
                      width: double.infinity,
                      height: 120.h, // Increased height to accommodate content
                      child: GridView.builder(
                        scrollDirection:
                            Axis.horizontal, // Enables horizontal scrolling
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, // Only one row
                          mainAxisSpacing:
                              4, // Spacing between items horizontally
                          childAspectRatio:
                              1 / 1.1, // Aspect ratio for each item
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return GestureDetector(
                            onTap: item.onTap,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(item.icon,
                                    height: 60.h, width: 60.w),
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
                        controller: authController.userNameController,
                        hintText: AppLocalizations.of(context)!.user_name,
                        borderColor: AppColors.secondaryPrimaryColor,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 16.w, right: 12.w),
                          child: SvgPicture.asset(AppIcons.email,
                              colorFilter: ColorFilter.mode(
                                  AppColors.primaryColor, BlendMode.srcIn),
                              height: 20.h,
                              width: 20.w),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_your_email;
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
                        controller: authController.passwordController,
                        isPassword: true,
                        hintText: AppLocalizations.of(context)!
                            .please_enter_your_password,
                        borderColor: AppColors.secondaryPrimaryColor,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 16.w, right: 12.w),
                          child: SvgPicture.asset(AppIcons.passIcon,
                              colorFilter: ColorFilter.mode(
                                  AppColors.primaryColor, BlendMode.srcIn),
                              height: 24.h,
                              width: 24.w),
                        ),
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

                    ///=============Forgot====================
                    InkWell(
                        onTap: () {
                          Get.toNamed(RouteName.forgotPasswordPage,
                              parameters: {
                                'email': authController.userNameController.text
                              });
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
                            authController.signInHandle(
                                userName:
                                    authController.userNameController.text,
                                password:
                                    authController.passwordController.text);

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
                              text: AppLocalizations.of(context)!
                                  .don_t_have_an_account,
                              fontsize: 20.sp,
                            )),
                        InkWell(
                            onTap: () {
                              Get.toNamed(RouteName.registrationPage,
                                  preventDuplicates: false);
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
