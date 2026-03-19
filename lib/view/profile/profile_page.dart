import 'package:al_wasyeah/controllers/profile/profile_controller.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';
import 'package:al_wasyeah/view/profile/profile_setup_step_five_screen.dart';
import 'package:al_wasyeah/view/profile/profile_setup_step_four_screen.dart';
import 'package:al_wasyeah/view/profile/profile_setup_step_one_screen.dart';
import 'package:al_wasyeah/view/profile/profile_setup_step_three_screen.dart';
import 'package:al_wasyeah/view/profile/profile_setup_step_two_screen.dart';
import 'package:al_wasyeah/view/widgets/background_image_screen_widget.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppLocalizations.of(context)!.profile_settings,
          fontWeight: FontWeight.w600,
          fontsize: 20.sp,
        ),
      ),
      body: BackgroundImageContainer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Step Indicator
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(
                    left: 26.0,
                    top: 20,
                    bottom: 20,
                  ),
                  child: Row(
                    children: List.generate(5, (index) {
                      bool isCompleted = index < controller.currentStep.value;
                      bool isActive = index == controller.currentStep.value;

                      return Expanded(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => controller.onStepTapped(index),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: isCompleted || isActive
                                      ? Colors.green
                                      : Colors.grey.shade300,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black26,
                                  ),
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            if (index < 4)
                              Expanded(
                                child: Container(
                                  height: 2,
                                  color: isCompleted
                                      ? Colors.green
                                      : Colors.grey.shade300,
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),

              // PageView for the screens
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.currentStep.value = index;
                  },
                  children: [
                    ProfileSettingStepOneWidget(),
                    ProfileSettingStepTwoWidget(),
                    ProfileSettingStepThreeWidget(),
                    ProfileSettingStepFourWidget(),
                    ProfileSettingStepFiveWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
