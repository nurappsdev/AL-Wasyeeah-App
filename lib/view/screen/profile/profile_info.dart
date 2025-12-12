import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../../helpers/helpers.dart';
import '../../../helpers/prefs_helper.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../profile_setting/profile_setting.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    userController.getUserProfileData();
    print("user data ${userController.userProfile.value?.firstName}");
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "User Profile".tr,
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
                    child: CircleAvatar(
                  radius: 50, // Radius of the CircleAvatar
                  backgroundImage: AssetImage(AppImages.profileIcon),
                  backgroundColor:
                      Colors.grey[200], // Optional background color
                )),
                // CustomNetworkImage(
                //   boxShape: BoxShape.circle,
                //   imageUrl: "assets/profile_icon.png",
                //   height: 120.h,
                //   width: 120.w,
                // ),
                SizedBox(
                  height: 10.h,
                ),
                Obx(() => CustomText(
                      text:
                          userController.userProfile.value?.firstName ?? "N/A",
                      fontsize: 18,
                      fontWeight: FontWeight.w700,
                    )),
                SizedBox(
                  height: 40.h,
                ),

                ///=====================Personal Details====================================
                GestureDetector(
                  onTap: () {
                    Get.off(() => StepNavigationWithPageView(),
                        preventDuplicates: false);
                    // Get.off(()=>MultiStepFormScreen(),preventDuplicates: false);
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
                                AppIcons.proIcon,
                              ),
                              SizedBox(width: 16.w),
                              CustomText(
                                text: "Personal Details".tr,
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

                ///=====================User Setting====================================
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
                              AppIcons.userSettingIcon,
                            ),
                            SizedBox(width: 16.w),
                            CustomText(
                              text: "User Setting".tr,
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
                SizedBox(
                  height: 20.h,
                ),

                ///=====================Device History====================================
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
                              AppIcons.userSettingIcon,
                            ),
                            SizedBox(width: 16.w),
                            CustomText(
                              text: "Device History".tr,
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
                SizedBox(
                  height: 20.h,
                ),

                ///=====================Device History====================================
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.accessControlTabScreen,
                        preventDuplicates: false);
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
                                AppIcons.accessIcon,
                              ),
                              SizedBox(width: 16.w),
                              CustomText(
                                text: "Access Control Panel".tr,
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
                              text: "Language".tr,
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
                SizedBox(
                  height: 20.h,
                ),

                SizedBox(height: 15.h),
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
                                text: "Log Out",
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
                    text: AppString.areYouSure,
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
                            title: 'Cancel',
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
                              title: 'LogOut',
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

                                await PrefsHelper.remove(AppConstants.isLogged);
                                Get.toNamed(AppRoutes.loginScreen,
                                    preventDuplicates: false);
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
    // Get.defaultDialog(
    //   title: 'Log Out',
    //   titleStyle: TextStyle(
    //       color: Colors.red,
    //       fontSize: 20.sp,
    //       fontWeight: FontWeight.bold),
    //   titlePadding: EdgeInsets.only(top: 20.h),
    //   contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
    //   backgroundColor: AppColors.whiteColor,
    //   radius: 12.r,
    //   barrierDismissible: false,
    //   content: SizedBox(
    //     width: MediaQuery.of(context).size.width * 0.9,
    //     height: 180.h,
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         SizedBox(height: 10.h),
    //         Divider(
    //           color: AppColors.primaryColor.withOpacity(0.7),
    //           thickness: 1.h,
    //           indent: 25.w,
    //           endIndent: 25.w,
    //         ),
    //         SizedBox(height: 10.h),
    //         CustomText(
    //           text: 'Are you sure you want to log out of your account?',
    //           textAlign: TextAlign.center,
    //           fontsize: 16.sp,
    //           color: AppColors.textColor4E4E4E,
    //         ),
    //         SizedBox(height: 20.h),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             ElevatedButton(
    //               onPressed: () {
    //                 Get.back();
    //               },
    //               style: ElevatedButton.styleFrom(
    //                 foregroundColor: AppColors.primaryColor,
    //                 overlayColor: Colors.green,
    //                 backgroundColor: Colors.white,
    //                 shadowColor: Colors.green,
    //                 fixedSize: Size(120.5.w, 60.h),
    //                 shape:  RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(16.sp),
    //
    //                 ),
    //                 padding: EdgeInsets.symmetric(vertical: 18.h,
    //                     horizontal: 16.w),
    //               ),
    //               child: Text(
    //                 'Cancel',
    //                 style: TextStyle(fontSize: 16.sp),
    //               ),
    //             ),
    //             SizedBox(width: 10.w),
    //             ElevatedButton(
    //               onPressed: () {
    //                 //  Get.offAllNamed(AppRoutes.roleScreen);
    //                 Get.back();
    //               },
    //               style: ElevatedButton.styleFrom(
    //                 foregroundColor: AppColors.whiteColor,
    //                 backgroundColor: Colors.red,
    //                 fixedSize: Size(130.5.w, 60.h),
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(16.sp),
    //                 ),
    //                 padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
    //               ),
    //               child: Text(
    //                 'Log Out',
    //                 style: TextStyle(fontSize: 16.sp),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
