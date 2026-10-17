import 'package:al_wasiyyath/app/core/themes/controller/theme_controller.dart';
import 'package:al_wasiyyath/app/view/auth/controller/auth_controller.dart';
import 'package:al_wasiyyath/app/view/home/controller/home_controller.dart';
import 'package:al_wasiyyath/app/core/widgets/custom_app_bar.dart';
import 'package:al_wasiyyath/app/view/profile/controller/profile_controller.dart';
import 'package:al_wasiyyath/app/core/route/route_names.dart';
import 'package:al_wasiyyath/app/core/utils/app_colors.dart';
import 'package:al_wasiyyath/app/core/utils/app_constant.dart';
import 'package:al_wasiyyath/app/core/utils/app_icons.dart';
import 'package:al_wasiyyath/app/core/widgets/custom_button_common.dart';
import 'package:al_wasiyyath/app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../core/services/shared_pref/prefs_service.dart';

import 'package:al_wasiyyath/app/app.dart';
import '../notification/controller/notification_controller.dart';
import '../../core/utils/api_constants.dart';
import 'package:al_wasiyyath/app/core/l10n/app_localizations.dart';
import 'package:al_wasiyyath/app/core/widgets/custom_text_field.dart';
import 'package:al_wasiyyath/app/core/utils/toast_message.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());
    final profileController = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());
    final themeController = Get.isRegistered<ThemeController>()
        ? Get.find<ThemeController>()
        : Get.put(ThemeController());
    final authController = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(AuthController());
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.user_profile,
      ),
      body: Container(
        height: Get.height,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Obx(() {
              final isDark = themeController.isDarkMode.value;
              return Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Center(
                    child: profileController.profileModel.value.userProfile
                                ?.profilePictureUrl !=
                            null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                "${ApiConstants.imageUrl + "${profileController.profileModel.value.userProfile?.profilePictureUrl}"}"),
                            backgroundColor: Colors.grey[200],
                          )
                        : CircleAvatar(
                            radius: 50,
                            child: const Icon(Icons.person),
                            backgroundColor: Colors.grey[200],
                          ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Builder(builder: (context) {
                    final user =
                        profileController.profileModel.value.userProfile;
                    final fullName =
                        "${user?.firstName ?? ''} ${user?.lastName ?? ''}"
                            .trim();
                    return CustomText(
                      text: fullName.isNotEmpty ? fullName : '',
                      fontsize: 18.sp,
                      fontWeight: FontWeight.w700,
                    );
                  }),
                  SizedBox(
                    height: 40.h,
                  ),

                  ///=====================Personal Details====================================
                  GestureDetector(
                    onTap: () => Get.toNamed(RouteName.profilePage,
                        preventDuplicates: false),
                    child: Container(
                      width: 360.w,
                      height: 60.h,
                      margin: EdgeInsets.only(left: 2.w),
                      decoration: _menuCardDecoration(isDark),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AppIcons.proIcon,
                                ),
                                SizedBox(width: 16.w),
                                CustomText(
                                  text: AppLocalizations.of(context)!
                                      .personal_details,
                                  fontsize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor4E4E4E,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: SvgPicture.asset(
                              AppIcons.chevronIcon,
                              colorFilter: ColorFilter.mode(
                                  AppColors.primaryColor, BlendMode.srcIn),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),

                  ///=====================Change Password====================================
                  GestureDetector(
                    onTap: () => Get.toNamed(RouteName.changePasswordPage,
                        preventDuplicates: false),
                    child: Container(
                      width: 360.w,
                      height: 60.h,
                      margin: EdgeInsets.only(left: 2.w),
                      decoration: _menuCardDecoration(isDark),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AppIcons.userSettingIcon,
                                ),
                                SizedBox(width: 16.w),
                                CustomText(
                                  text: AppLocalizations.of(context)!
                                      .change_password,
                                  fontsize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor4E4E4E,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: SvgPicture.asset(
                              AppIcons.chevronIcon,
                              colorFilter: ColorFilter.mode(
                                  AppColors.primaryColor, BlendMode.srcIn),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),

                  //====================== Delete Account ====================================
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor:
                              Theme.of(context).dialogTheme.backgroundColor ??
                                  Theme.of(context).colorScheme.surface,
                          title: CustomText(
                            text: AppLocalizations.of(context)!
                                .sure_you_want_to_delete_account,
                            fontsize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textColor4E4E4E,
                          ),
                          content: CustomText(
                            text: AppLocalizations.of(context)!
                                .delete_account_desc,
                            fontsize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textColor4E4E4E,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: CustomText(
                                text: AppLocalizations.of(context)!.cancel,
                                fontsize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textColor4E4E4E,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.back();
                                _showPasswordConfirmDialog(
                                    context, authController);
                              },
                              child: CustomText(
                                text: AppLocalizations.of(context)!.delete,
                                fontsize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    child: Container(
                      width: 360.w,
                      height: 60.h,
                      margin: EdgeInsets.only(left: 2.w),
                      decoration: _menuCardDecoration(isDark),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: const Color(0xFF39B048),
                                  child: SvgPicture.asset(
                                    AppIcons.deleteIcon,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn),
                                    width: 22.w,
                                    height: 22.h,
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                CustomText(
                                  text: AppLocalizations.of(context)!
                                      .delete_account,
                                  fontsize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor4E4E4E,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: SvgPicture.asset(
                              AppIcons.chevronIcon,
                              colorFilter: ColorFilter.mode(
                                  AppColors.primaryColor, BlendMode.srcIn),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20.h,
                  ),

                  ///=====================Access Control====================================
                  InkWell(
                    onTap: () => Get.toNamed(RouteName.accessControlPage,
                        preventDuplicates: false),
                    child: Container(
                      width: 360.w,
                      height: 60.h,
                      margin: EdgeInsets.only(left: 2.w),
                      decoration: _menuCardDecoration(isDark),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AppIcons.accessIcon,
                                ),
                                SizedBox(width: 16.w),
                                CustomText(
                                  text: AppLocalizations.of(context)!
                                      .access_control_panel,
                                  fontsize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor4E4E4E,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: SvgPicture.asset(
                              AppIcons.chevronIcon,
                              colorFilter: ColorFilter.mode(
                                  AppColors.primaryColor, BlendMode.srcIn),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20.h,
                  ),

                  ///=====================User Menus====================================
                  ...homeController.userMenus
                      .where((menu) => menu.activeYn == "Y")
                      .toList()
                      .map((menu) {
                    return Column(
                      children: [
                        menu.subMenus.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(left: 2.w),
                                decoration: _menuCardDecoration(isDark),
                                child: ExpansionTile(
                                  tilePadding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide.none),
                                  title: Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppIcons.accessIcon,
                                      ),
                                      SizedBox(width: 16.w),
                                      CustomText(
                                        text: menu.menuName,
                                        fontsize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textColor4E4E4E,
                                      )
                                    ],
                                  ),
                                  trailing: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.primaryColor,
                                    size: 24.sp,
                                  ),
                                  children: menu.subMenus.map((subMenu) {
                                    return ListTile(
                                      onTap: () => Get.toNamed(
                                          RouteName.accessCntrolPanelPage,
                                          arguments: subMenu.submenuId),
                                      title: CustomText(
                                        text: subMenu.submenuName,
                                        fontsize: 14.sp,
                                        color: AppColors.textColor4E4E4E,
                                      ),
                                      trailing: Icon(Icons.arrow_forward_ios,
                                          size: 14.sp,
                                          color: AppColors.primaryColor),
                                    );
                                  }).toList(),
                                ),
                              )
                            : const SizedBox.shrink(),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    );
                  }),

                  ///=====================Language====================================
                  Container(
                    width: 360.w,
                    height: 60.h,
                    margin: EdgeInsets.only(left: 2.w),
                    decoration: _menuCardDecoration(isDark),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.languageIcon,
                              ),
                              SizedBox(width: 16.w),
                              CustomText(
                                text: AppLocalizations.of(context)!.language,
                                fontsize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textColor4E4E4E,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Row(
                            children: [
                              CustomText(
                                text: "En",
                                fontsize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Localizations.localeOf(context)
                                            .languageCode ==
                                        'en'
                                    ? AppColors.primaryColor
                                    : Colors.grey,
                              ),
                              Switch(
                                value: Localizations.localeOf(context)
                                        .languageCode ==
                                    'bn',
                                onChanged: (value) {
                                  Locale newLocale = value
                                      ? const Locale('bn')
                                      : const Locale('en');
                                  WasyeeahApp.setLocale(context, newLocale);
                                },
                                activeThumbColor: AppColors.primaryColor,
                              ),
                              CustomText(
                                text: "Bn",
                                fontsize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Localizations.localeOf(context)
                                            .languageCode ==
                                        'bn'
                                    ? AppColors.primaryColor
                                    : Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),

                  ///=====================Theme Switch====================================
                  Container(
                    width: 360.w,
                    height: 60.h,
                    margin: EdgeInsets.only(left: 2.w),
                    decoration: _menuCardDecoration(isDark),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Row(
                            children: [
                              Icon(
                                isDark
                                    ? Icons.dark_mode
                                    : Icons.dark_mode_outlined,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(width: 16.w),
                              CustomText(
                                text: AppLocalizations.of(context)!.dark_mode,
                                fontsize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textColor4E4E4E,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Switch(
                            value: themeController.isDarkMode.value,
                            onChanged: (value) {
                              themeController.toggleTheme();
                            },
                            activeThumbColor: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //=====================About Us====================================
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(RouteName.aboutPage,
                        preventDuplicates: false),
                    child: Container(
                      width: 360.w,
                      height: 60.h,
                      margin: EdgeInsets.only(left: 2.w),
                      decoration: _menuCardDecoration(isDark),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Row(
                              children: [
                                Container(
                                  width: 30.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF39B048),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.r)),
                                  ),
                                  child: Icon(
                                    Icons.info_outline,
                                    size: 12.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                CustomText(
                                  text: AppLocalizations.of(context)!.about_us,
                                  fontsize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor4E4E4E,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: SvgPicture.asset(
                              AppIcons.chevronIcon,
                              colorFilter: ColorFilter.mode(
                                  AppColors.primaryColor, BlendMode.srcIn),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //=====================Contact Us====================================

                  GestureDetector(
                    onTap: () => Get.toNamed(RouteName.contactPage,
                        preventDuplicates: false),
                    child: Container(
                      width: 360.w,
                      height: 60.h,
                      margin: EdgeInsets.only(left: 2.w),
                      decoration: _menuCardDecoration(isDark),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Row(
                              children: [
                                Container(
                                  width: 30.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF39B048),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.r)),
                                  ),
                                  child: Icon(
                                    Icons.call_outlined,
                                    size: 12.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                CustomText(
                                  text:
                                      AppLocalizations.of(context)!.contact_us,
                                  fontsize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor4E4E4E,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: SvgPicture.asset(
                              AppIcons.chevronIcon,
                              colorFilter: ColorFilter.mode(
                                  AppColors.primaryColor, BlendMode.srcIn),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //=====================Logout====================================

                  GestureDetector(
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                    child: Container(
                      width: 360.w,
                      height: 60.h,
                      margin: EdgeInsets.only(left: 2.w),
                      decoration: _menuCardDecoration(isDark),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AppIcons.logoutIcon,
                                  colorFilter: ColorFilter.mode(
                                      AppColors.primaryColor, BlendMode.srcIn),
                                ),
                                SizedBox(width: 16.w),
                                CustomText(
                                  text: AppLocalizations.of(context)!.log_out,
                                  fontsize: 14.sp,
                                  color: AppColors.textColor4E4E4E,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  BoxDecoration _menuCardDecoration(bool isDark) {
    return BoxDecoration(
      color: isDark ? const Color(0xFF1E1E1E) : AppColors.whiteColor,
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
      border: Border.all(
        color: isDark ? const Color(0xFF2C3E35) : const Color(0xffB0E3D3),
        width: 2.w,
      ),
    );
  }

  ///==============log out =======================
  void _showLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 24.w, vertical: 26.h),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: AppLocalizations.of(context)!.are_you_sure,
                    fontsize: 16.sp,
                    fontWeight: FontWeight.w600,
                    maxline: 2,
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    spacing: 16.w,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 120.w,
                          height: 40.h,
                          child: CustomButton(
                            title: AppLocalizations.of(context)!.cancel,
                            fontSize: 16.h,
                            onpress: () {
                              Get.back();
                            },
                            color: Colors.white,
                            titlecolor: AppColors.primaryColor,
                          )),
                      SizedBox(
                          width: 120.w,
                          height: 40.h,
                          child: CustomButton(
                              color: AppColors.secondaryPrimaryColor,
                              titlecolor: AppColors.primaryColor,
                              title: AppLocalizations.of(context)!.logout,
                              fontSize: 16.h,
                              onpress: () async {
                                //   profileController.promoCode.value = "";
                                await PrefsHelper.remove(
                                    AppConstants.bearerToken);
                                await PrefsHelper.remove(AppConstants.userId);
                                await PrefsHelper.remove(
                                    AppConstants.firstname);
                                await PrefsHelper.remove(AppConstants.lastname);
                                // await PrefsHelper.remove(AppConstants.userName);
                                await PrefsHelper.remove(AppConstants.phone);
                                await PrefsHelper.remove(AppConstants.image);
                                await PrefsHelper.remove(AppConstants.email);
                                await PrefsHelper.remove(
                                    AppConstants.businessID);
                                await PrefsHelper.remove(AppConstants.type);

                                // Clear controllers to avoid stale data
                                Get.delete<HomeController>(force: true);
                                Get.delete<NotificationController>(force: true);
                                Get.delete<ProfileController>(force: true);

                                Get.offAllNamed(RouteName.loginPage);
                              })),
                    ],
                  )
                ],
              ),
              elevation: 12.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(width: 1.w, color: AppColors.primaryColor)));
        });
  }

  ///============== Password confirmation for delete account =======================
  void _showPasswordConfirmDialog(
      BuildContext context, AuthController authController) {
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          title: CustomText(
            text: AppLocalizations.of(context)!.current_password,
            fontsize: 18.sp,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: AppLocalizations.of(context)!.enter_your_password,
                  fontsize: 14.sp,
                  color: AppColors.textColor4E4E4E,
                ),
                SizedBox(height: 12.h),
                CustomTextField(
                  controller: passwordController,
                  isPassword: true,
                  hintText: AppLocalizations.of(context)!.password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!
                          .please_enter_your_password;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: CustomText(
                text: AppLocalizations.of(context)!.cancel,
                fontsize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor4E4E4E,
              ),
            ),
            Obx(
              () => authController.isDeletingAccount.value
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                  : TextButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final enteredPassword =
                              passwordController.text.trim();
                          final savedPassword = await PrefsHelper.getString(
                              AppConstants.password);

                          if (savedPassword.isNotEmpty &&
                              enteredPassword != savedPassword) {
                            ToastMessage.errorMessageShowToster(
                              AppLocalizations.of(context)!.incorrect_password,
                            );
                            return;
                          }

                          await authController.deleteAccount(enteredPassword);
                        }
                      },
                      child: CustomText(
                        text: AppLocalizations.of(context)!.delete,
                        fontsize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
