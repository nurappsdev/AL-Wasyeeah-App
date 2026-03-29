import 'package:al_wasyeah/controllers/home/home_controller.dart';
import 'package:al_wasyeah/controllers/profile/profile_controller.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/utils/app_constant.dart';
import 'package:al_wasyeah/utils/app_icons.dart';
import 'package:al_wasyeah/view/widgets/background_image_screen_widget.dart';
import 'package:al_wasyeah/view/widgets/custom_button.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../helpers/helpers.dart';
import '../../helpers/prefs_helper.dart';

import 'package:al_wasyeah/view/app.dart';
import '../../controllers/notification/notification_controller.dart';
import '../../services/api_constants.dart';
import '../profile/profile_page.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final profileController = Get.find<ProfileController>();
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppLocalizations.of(context)!.user_profile,
          fontsize: 18.sp,
        ),
      ),
      body: BackgroundImageContainer(
        child: Container(
          height: Get.height,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Center(
                  child: Obx(
                    () => profileController.profileModel.value.userProfile
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
                            child: Icon(Icons.person),
                            backgroundColor: Colors.grey[200],
                          ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Obx(() => CustomText(
                      text:
                          "${profileController.profileModel.value.userProfile?.firstName} ${profileController.profileModel.value.userProfile?.lastName}",
                      fontsize: 18.sp,
                      fontWeight: FontWeight.w700,
                    )),
                SizedBox(
                  height: 40.h,
                ),

                ///=====================Personal Details====================================
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.profilePage,
                      preventDuplicates: false),
                  child: Container(
                    width: 360.w,
                    height: 60.h,
                    margin: EdgeInsets.only(left: 2.w),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      border: Border.all(
                        color: Color(0xffB0E3D3),
                        width: 2.w,
                      ),
                    ),
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
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),

                ///=====================Change  Password====================================
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.changePasswordPage,
                      preventDuplicates: false),
                  child: Container(
                    width: 360.w,
                    height: 60.h,
                    margin: EdgeInsets.only(left: 2.w),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      border: Border.all(
                        color: Color(0xffB0E3D3),
                        width: 2.w,
                      ),
                    ),
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
                            color: AppColors.primaryColor,
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
                  onTap: () => Get.toNamed(AppRoutes.accessControlPage,
                      preventDuplicates: false),
                  child: Container(
                    width: 360.w,
                    height: 60.h,
                    margin: EdgeInsets.only(left: 2.w),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      border: Border.all(
                        color: Color(0xffB0E3D3),
                        width: 2.w,
                      ),
                    ),
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
                            color: AppColors.primaryColor,
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
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.r)),
                                border: Border.all(
                                  color: const Color(0xffB0E3D3),
                                  width: 2.w,
                                ),
                              ),
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
                                    onTap: () {
                                      // Handle submenu navigation
                                    },
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
                          : InkWell(
                              onTap: () {
                                if (menu.menuId ==
                                    "A8E6179D0F256C2C79F5F84AE19FAF0D") {
                                  Get.toNamed(AppRoutes.accessControlPage,
                                      preventDuplicates: false);
                                } else {
                                  Get.toNamed(AppRoutes.accessControlPage,
                                      preventDuplicates: false);
                                }
                              },
                              child: Container(
                                width: 360.w,
                                height: 60.h,
                                margin: EdgeInsets.only(left: 2.w),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
                                  border: Border.all(
                                    color: const Color(0xffB0E3D3),
                                    width: 2.w,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w),
                                      child: Row(
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
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w),
                                      child: SvgPicture.asset(
                                        AppIcons.chevronIcon,
                                        color: AppColors.primaryColor,
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

                ///=====================Language====================================
                Container(
                  width: 360.w,
                  height: 60.h,
                  margin: EdgeInsets.only(left: 2.w),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    border: Border.all(
                      color: Color(0xffB0E3D3),
                      width: 2.w,
                    ),
                  ),
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
                              activeColor: AppColors.primaryColor,
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

                GestureDetector(
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                  child: Container(
                    width: 360.w,
                    height: 60.h,
                    margin: EdgeInsets.only(left: 2.w),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      border: Border.all(
                        color: Color(0xffB0E3D3),
                        width: 2.w,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.logoutIcon,
                                color: AppColors.primaryColor,
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
              ],
            )),
          ),
        ),
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

                                Get.offAllNamed(AppRoutes.loginPage);
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
}
