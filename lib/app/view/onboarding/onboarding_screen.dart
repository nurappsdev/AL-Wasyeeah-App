import 'package:al_wasyeah/core/services/app_routes.dart';
import 'package:al_wasyeah/core/utils/app_colors.dart';
import 'package:al_wasyeah/core/utils/app_image.dart';
import 'package:al_wasyeah/app/app.dart';
import 'package:al_wasyeah/core/widgets/custom_button_common.dart';
import 'package:al_wasyeah/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:al_wasyeah/core/l10n/app_localizations.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isEnglish = Localizations.localeOf(context).languageCode == 'en';

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 10.w, left: 10.w),
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Center(
                child: Image.asset(
              AppImages.initialRouteBackgroundImage,
              fit: BoxFit.fitHeight,
              height: double.infinity,
              width: double.infinity,
            )),
            Positioned(
              top: 330.h,
              right: 60.w,
              left: 60,
              child: SizedBox(
                height: Get.height,
                child: CustomText(
                  text: AppLocalizations.of(context)!.ayat,
                  maxline: 20,
                  fontsize: 16.sp,
                ),
              ),
            ),
            Positioned(
              top: 30.h,
              right: 4.w,
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: TextStyle(color: Colors.black, fontSize: 16.sp),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            WasyeeahApp.setLocale(context, const Locale('en'));
                          },
                          child: Text(
                            'Eng',
                            style: TextStyle(
                              color: isEnglish ? AppColors.primaryColor : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Switch(
                          value: !isEnglish,
                          onChanged: (value) {
                            WasyeeahApp.setLocale(context, value ? const Locale('bn') : const Locale('en'));
                          },
                          activeColor: AppColors.primaryColor,
                          inactiveThumbColor: AppColors.primaryColor,
                          inactiveTrackColor: Colors.grey.shade300,
                          activeTrackColor: Colors.grey.shade300,
                        ),
                        GestureDetector(
                          onTap: () {
                            WasyeeahApp.setLocale(context, const Locale('bn'));
                          },
                          child: Text(
                            'বাং',
                            style: TextStyle(
                              color: isEnglish ? Colors.black : AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 12,
              child: Padding(
                padding: EdgeInsets.all(8.r),
                child: CustomButton(
                  title: AppLocalizations.of(context)!.get_start,
                  onpress: () {
                    Get.toNamed(AppRoutes.loginPage, preventDuplicates: false);
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
