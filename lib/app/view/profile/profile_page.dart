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
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final shouldExit =
            await showProfileFormFillUpExitConfirmationDialog(context);

        if (!context.mounted) return;

        if (shouldExit == true) {
          controller.resetUiValues();

          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: AppLocalizations.of(context)!.profile_settings,
          onBackPressed: () async {
            final shouldExit =
                await showProfileFormFillUpExitConfirmationDialog(context);

            if (shouldExit == true && context.mounted) {
              controller.resetUiValues();

              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                Get.back();
              }
            }
          },
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
                          final currentStep = controller.currentStep.value;

                          final bool isCompleted = index < currentStep;
                          final bool isActive = index == currentStep;

                          final formKeys = [
                            controller.step1formKey,
                            controller.step2formKey,
                            controller.step3formKey,
                            controller.step4formKey,
                            controller.step5formKey,
                          ];

                          return Expanded(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Already in this step
                                    if (index == currentStep) return;

                                    // BACK NAVIGATION: No validation required
                                    if (index < currentStep) {
                                      controller.onStepTapped(index);
                                      return;
                                    }

                                    // NEXT NAVIGATION: Only allow the immediate next step
                                    if (index == currentStep + 1) {
                                      final isValid = formKeys[currentStep]
                                              .currentState
                                              ?.validate() ??
                                          false;

                                      if (isValid) {
                                        controller.onStepTapped(index);
                                      }
                                    }
                                  },
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
                      )),

                  // PageView for the screens
                  Expanded(
                    child: PageView(
                      controller: controller.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        final currentStep = controller.currentStep.value;

                        final formKeys = [
                          controller.step1formKey,
                          controller.step2formKey,
                          controller.step3formKey,
                          controller.step4formKey,
                          controller.step5formKey,
                        ];

                        // Same page
                        if (index == currentStep) return;

                        // BACK NAVIGATION: No validation
                        if (index < currentStep) {
                          controller.onStepTapped(index);
                          return;
                        }

                        // NEXT NAVIGATION: Only allow the immediate next page
                        if (index == currentStep + 1) {
                          final isValid =
                              formKeys[currentStep].currentState?.validate() ??
                                  false;

                          if (isValid) {
                            controller.onStepTapped(index);
                          } else {
                            // Validation failed: Return to current page
                            controller.pageController.jumpToPage(currentStep);
                          }

                          return;
                        }

                        // Prevent skipping steps
                        controller.pageController.jumpToPage(currentStep);
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

  Future<bool?> showProfileFormFillUpExitConfirmationDialog(
    BuildContext context,
  ) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            AppLocalizations.of(context)!.exit_profile_form_title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            AppLocalizations.of(context)!.exit_profile_form_subtitle,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: Text(AppLocalizations.of(context)!.stay),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: Text(AppLocalizations.of(context)!.exit),
            ),
          ],
        );
      },
    );
  }
}
