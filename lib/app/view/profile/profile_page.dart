import 'package:wasiyyat/app/core/utils/app_colors.dart';
import 'package:wasiyyat/app/view/profile/controller/profile_controller.dart';
import 'package:wasiyyat/app/core/widgets/custom_app_bar.dart';
import 'package:wasiyyat/app/core/l10n/app_localizations.dart';
import 'package:wasiyyat/app/view/profile/profile_setup_step_five_screen.dart';
import 'package:wasiyyat/app/view/profile/profile_setup_step_four_screen.dart';
import 'package:wasiyyat/app/view/profile/profile_setup_step_one_screen.dart';
import 'package:wasiyyat/app/view/profile/profile_setup_step_three_screen.dart';
import 'package:wasiyyat/app/view/profile/profile_setup_step_two_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController controller = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getProfilePageData();
    });
  }

  @override
  void dispose() {
    controller.resetUiValues();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          controller.resetUiValues();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: AppLocalizations.of(context)!.profile_settings,
        ),
        body: Obx(() {
          final isLoading = controller.status.value.isLoading;

          return Skeletonizer(
            enabled: isLoading,
            effect: ShimmerEffect(
              baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
              highlightColor:
                  isDark ? Colors.grey.shade700 : Colors.grey.shade100,
            ),
            containersColor:
                isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Step Indicator
                  Padding(
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
                                        ? AppColors.primaryColor
                                        : (isDark
                                            ? Colors.grey.shade800
                                            : Colors.grey.shade300),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isDark
                                          ? Colors.white24
                                          : Colors.black26,
                                    ),
                                  ),
                                  child: const Icon(
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
                                        ? AppColors.primaryColor
                                        : (isDark
                                            ? Colors.grey.shade800
                                            : Colors.grey.shade300),
                                  ),
                                ),
                            ],
                          ),
                        );
                      }),
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
                        const ProfileSettingStepTwoWidget(),
                        ProfileSettingStepThreeWidget(),
                        ProfileSettingStepFourWidget(),
                        ProfileSettingStepFiveWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
