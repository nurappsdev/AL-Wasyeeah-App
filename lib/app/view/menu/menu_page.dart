import 'package:al_wasyeah/app/controllers/home/home_controller.dart';
import 'package:al_wasyeah/app/view/widgets/custom_app_bar.dart';
import 'package:al_wasyeah/app/controllers/profile/profile_controller.dart';
import 'package:al_wasyeah/app/controllers/theme_controller.dart';
import 'package:al_wasyeah/core/services/app_routes.dart';
import 'package:al_wasyeah/core/utils/app_colors.dart';
import 'package:al_wasyeah/core/utils/app_constant.dart';
import 'package:al_wasyeah/core/utils/app_icons.dart';
import 'package:al_wasyeah/core/widgets/custom_button_common.dart';
import 'package:al_wasyeah/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/services/prefs_helper.dart';

import 'package:al_wasyeah/app/app.dart';
import '../../controllers/notification/notification_controller.dart';
import '../../../core/services/api_constants.dart';
import 'package:al_wasyeah/core/l10n/app_localizations.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final profileController = Get.find<ProfileController>();
    final themeController = Get.find<ThemeController>();
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
              GestureDetector(
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
                              text:
                                  AppLocalizations.of(context)!.change_password,
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
                                  onTap: () => Get.toNamed(
                                      AppRoutes.accessCntrolPanelPage,
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
                        : SizedBox.shrink(),
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
                            color:
                                Localizations.localeOf(context).languageCode ==
                                        'en'
                                    ? AppColors.primaryColor
                                    : Colors.grey,
                          ),
                          Switch(
                            value:
                                Localizations.localeOf(context).languageCode ==
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
                            color:
                                Localizations.localeOf(context).languageCode ==
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
              // Container(
              //   width: 360.w,
              //   height: 60.h,
              //   margin: EdgeInsets.only(left: 2.w),
              //   decoration: BoxDecoration(
              //     color: AppColors.whiteColor,
              //     borderRadius: BorderRadius.all(Radius.circular(8.r)),
              //     border: Border.all(
              //       color: Color(0xffB0E3D3),
              //       width: 2.w,
              //     ),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Padding(
              //         padding: EdgeInsets.symmetric(horizontal: 12.w),
              //         child: Row(
              //           children: [
              //             Icon(Icons.dark_mode_outlined, color: AppColors.primaryColor),
              //             SizedBox(width: 16.w),
              //             CustomText(
              //               text: "Dark Mode",
              //               fontsize: 16.sp,
              //               fontWeight: FontWeight.w600,
              //               color: AppColors.textColor4E4E4E,
              //             )
              //           ],
              //         ),
              //       ),
              //       Padding(
              //         padding: EdgeInsets.symmetric(horizontal: 12.w),
              //         child: Obx(
              //           () => Switch(
              //             value: themeController.isDarkMode.value,
              //             onChanged: (value) {
              //               themeController.toggleTheme();
              //             },
              //             activeColor: AppColors.primaryColor,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              //=====================About Us====================================

              GestureDetector(
                onTap: () =>
                    Get.toNamed(AppRoutes.aboutPage, preventDuplicates: false),
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
                            Container(
                              width: 30.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: Color(0xFF39B048),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.r)),
                              ),
                              child: Icon(
                                Icons.info_outline,
                                size: 12.sp,
                                color: AppColors.whiteColor,
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
              //=====================Contact Us====================================

              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.contactPage,
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
                            Container(
                              width: 30.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: Color(0xFF39B048),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.r)),
                              ),
                              child: Icon(
                                Icons.call_outlined,
                                size: 12.sp,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            CustomText(
                              text: AppLocalizations.of(context)!.contact_us,
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
              //=====================Logout====================================

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
              SizedBox(
                height: 20.h,
              ),
            ],
          )),
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
