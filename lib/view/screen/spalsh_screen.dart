import 'package:al_wasyeah/helpers/app_routes.dart';
import 'package:al_wasyeah/services/translation/language_service.dart';
import 'package:al_wasyeah/view/widgets/custom_button_common.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

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
        padding: EdgeInsets.only(right: 10, left: 10),
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
              top: 330,
              right: 60,
              left: 60,
              child: SizedBox(
                height: 200,
                child: CustomText(
                  text: "ayat".tr,
                  maxline: 20,
                  fontsize: 16,
                ),
              ),
            ),
            Positioned(
              top: 30,
              right: 4,
              child: Obx(
                () => Row(
                  children: [
                    Text(
                      'language'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    // Toggle for language
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
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
                                fontSize: 14,
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
                                fontSize: 14,
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
              bottom: 12,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(8),
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
