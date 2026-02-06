import 'package:al_wasyeah/utils/app_image.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../../helpers/helpers.dart';
import '../../../services/database_helper.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_constant.dart';
import '../../widgets/widgets.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    userController.getUserProfileData();
    print("user data ${userController.userProfile.value?.firstName}");
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'userProfile'.tr,
          fontsize: 18,
        ),
      ),
      body: BackgroundImageContainer(
        child: Container(
          height: Get.height,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(
                  height: 40,
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
                //   height: 120,
                //   width: 120,
                // ),
                SizedBox(
                  height: 10,
                ),
                Obx(() => CustomText(
                      text:
                          userController.userProfile.value?.firstName ?? "N/A",
                      fontsize: 18,
                      fontWeight: FontWeight.w700,
                    )),
                SizedBox(
                  height: 40,
                ),

                ///=====================Personal Details====================================
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.profilePage);
                  },
                  child: Container(
                    width: 360,
                    height: 60,
                    margin: EdgeInsets.only(left: 2),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                        color: Color(0xffB0E3D3),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.proIcon,
                              ),
                              SizedBox(width: 16),
                              CustomText(
                                text: 'personalDetails'.tr,
                                fontsize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textColor4E4E4E,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
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
                  height: 20,
                ),

                ///=====================Property Distribution Calculation====================================
                GestureDetector(
                    onTap: () {
                      Get.toNamed(
                          AppRoutes.propertyDistributionCalculationScreen);
                    },
                    child: Container(
                      width: 360,
                      height: 60,
                      margin: EdgeInsets.only(left: 2),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                          color: const Color(0xffB0E3D3),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          // LEFT SIDE (ICON + TEXT)
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Color(0xFF39B048),
                                    child: Icon(
                                      Icons.calculate,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: CustomText(
                                      text: 'propertyDistributionTitle'.tr,
                                      fontsize: 16,
                                      textOverflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textColor4E4E4E,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // RIGHT CHEVRON ICON
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: SvgPicture.asset(
                              AppIcons.chevronIcon,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),

                ///=====================User Setting====================================
                Container(
                  width: 360,
                  height: 60,
                  margin: EdgeInsets.only(left: 2),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: Color(0xffB0E3D3),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.userSettingIcon,
                            ),
                            SizedBox(width: 16),
                            CustomText(
                              text: 'userSetting'.tr,
                              fontsize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColor4E4E4E,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: SvgPicture.asset(
                          AppIcons.chevronIcon,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                ///=====================Device History====================================
                Container(
                  width: 360,
                  height: 60,
                  margin: EdgeInsets.only(left: 2),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: Color(0xffB0E3D3),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.userSettingIcon,
                            ),
                            SizedBox(width: 16),
                            CustomText(
                              text: 'deviceHistory'.tr,
                              fontsize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColor4E4E4E,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: SvgPicture.asset(
                          AppIcons.chevronIcon,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                ///=====================Device History====================================
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.accessControlTabScreen,
                        preventDuplicates: false);
                  },
                  child: Container(
                    width: 360,
                    height: 60,
                    margin: EdgeInsets.only(left: 2),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                        color: Color(0xffB0E3D3),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.accessIcon,
                              ),
                              SizedBox(width: 16),
                              CustomText(
                                text: 'accessControlPanel'.tr,
                                fontsize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textColor4E4E4E,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
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
                  height: 20,
                ),

                ///=====================Language====================================
                Container(
                  width: 360,
                  height: 60,
                  margin: EdgeInsets.only(left: 2),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: Color(0xffB0E3D3),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.languageIcon,
                            ),
                            SizedBox(width: 16),
                            CustomText(
                              text: 'language'.tr,
                              fontsize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColor4E4E4E,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: SvgPicture.asset(
                          AppIcons.chevronIcon,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                  child: Container(
                    width: 360,
                    height: 60,
                    margin: EdgeInsets.only(left: 2),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                        color: Color(0xffB0E3D3),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.logoutIcon,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(width: 16),
                              CustomText(
                                text: 'loOut'.tr,
                                fontsize: 14,
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
                  EdgeInsets.symmetric(horizontal: 24, vertical: 26),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: 'areYouSure'.tr,
                    fontsize: 16,
                    fontWeight: FontWeight.w600,
                    maxline: 2,
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 120,
                          height: 40,
                          child: CustomButton(
                            title: 'cancel'.tr,
                            fontSize: 16,
                            onpress: () {
                              Get.back();
                            },
                            color: Colors.white,
                            titlecolor: AppColors.primaryColor,
                          )),
                      SizedBox(
                          width: 120,
                          height: 40,
                          child: CustomButton(
                              color: AppColors.secondaryPrimaryColor,
                              titlecolor: AppColors.primaryColor,
                              title: 'loOut'.tr,
                              fontSize: 16,
                              onpress: () async {
                                Get.toNamed(AppRoutes.loginScreen,
                                    preventDuplicates: false);
                              })),
                    ],
                  )
                ],
              ),
              elevation: 12.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(width: 1, color: AppColors.primaryColor)));
        });
    // Get.defaultDialog(
    //   title: 'Log Out',
    //   titleStyle: TextStyle(
    //       color: Colors.red,
    //       fontSize: 20,
    //       fontWeight: FontWeight.bold),
    //   titlePadding: EdgeInsets.only(top: 20),
    //   contentPadding: EdgeInsets.symmetric(horizontal: 20),
    //   backgroundColor: AppColors.whiteColor,
    //   radius: 12,
    //   barrierDismissible: false,
    //   content: SizedBox(
    //     width: MediaQuery.of(context).size.width * 0.9,
    //     height: 180,
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         SizedBox(height: 10),
    //         Divider(
    //           color: AppColors.primaryColor.withOpacity(0.7),
    //           thickness: 1,
    //           indent: 25,
    //           endIndent: 25,
    //         ),
    //         SizedBox(height: 10),
    //         CustomText(
    //           text: 'Are you sure you want to log out of your account?',
    //           textAlign: TextAlign.center,
    //           fontsize: 16,
    //           color: AppColors.textColor4E4E4E,
    //         ),
    //         SizedBox(height: 20),
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
    //                 fixedSize: Size(120.5, 60),
    //                 shape:  RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(16),
    //
    //                 ),
    //                 padding: EdgeInsets.symmetric(vertical: 18,
    //                     horizontal: 16),
    //               ),
    //               child: Text(
    //                 'Cancel',
    //                 style: TextStyle(fontSize: 16),
    //               ),
    //             ),
    //             SizedBox(width: 10),
    //             ElevatedButton(
    //               onPressed: () {
    //                 //  Get.offAllNamed(AppRoutes.roleScreen);
    //                 Get.back();
    //               },
    //               style: ElevatedButton.styleFrom(
    //                 foregroundColor: AppColors.whiteColor,
    //                 backgroundColor: Colors.red,
    //                 fixedSize: Size(130.5, 60),
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(16),
    //                 ),
    //                 padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    //               ),
    //               child: Text(
    //                 'Log Out',
    //                 style: TextStyle(fontSize: 16),
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
