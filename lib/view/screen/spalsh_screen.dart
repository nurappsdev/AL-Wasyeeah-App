import 'package:al_wasyeah/helpers/app_routes.dart';
import 'package:al_wasyeah/services/translation/language_service.dart';
import 'package:al_wasyeah/view/widgets/custom_button_common.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/app_image.dart';
import '../../utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Initialize the language controller
  final LanguageService languageService = Get.put(LanguageService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 10.w, left: 10.w),
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                AppImages.splashImg1,
                fit: BoxFit.fitHeight,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            Positioned(
              top: 330.h,
              right: 60.w,
              left: 60.w,
              child: SizedBox(
                height: 200.h,
                child: CustomText(
                  text: "ayat".tr,
                  maxline: 20,
                  fontsize: 16.sp,
                ),
              ),
            ),
            Positioned(
              top: 30.h,
              right: 4.w,
              child: Obx(
                () => Row(
                  children: [
                    Text(
                      'language'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    // Toggle for language
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // English Label
                          GestureDetector(
                            onTap: () {
                              languageService.changeLanguage('en', 'US');
                            },
                            child: Text(
                              'Eng',
                              style: TextStyle(
                                color: languageService.isEnglish
                                    ? AppColors.primaryColor
                                    : Colors.grey,
                                fontWeight: languageService.isEnglish
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          // Switch
                          Switch(
                            value: languageService.isBangla,
                            onChanged: (value) {
                              if (value) {
                                // Switch to Bangla
                                languageService.changeLanguage('bn', 'BD');
                              } else {
                                // Switch to English
                                languageService.changeLanguage('en', 'US');
                              }
                            },
                            activeThumbColor: AppColors.primaryColor,
                            activeTrackColor:
                                AppColors.primaryColor.withOpacity(0.5),
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.grey.shade400,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                          // Bangla Label
                          GestureDetector(
                            onTap: () {
                              languageService.changeLanguage('bn', 'BD');
                            },
                            child: Text(
                              'বাং',
                              style: TextStyle(
                                color: languageService.isBangla
                                    ? AppColors.primaryColor
                                    : Colors.grey,
                                fontWeight: languageService.isBangla
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 12.h,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(8.r),
                child: CustomButtonCommon(
                  title: 'getStart'.tr,
                  onpress: () {
                    Get.toNamed(
                      AppRoutes.loginScreen,
                      preventDuplicates: false,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}