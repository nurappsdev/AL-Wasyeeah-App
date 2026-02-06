import 'package:al_wasyeah/utils/app_dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import '../../controllers/controllers.dart';
import '../../helpers/helpers.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constant.dart';
import '../../utils/app_icons.dart';
import '../widgets/widgets.dart';
import 'before_login/profirty_Distribute_screen2.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController =
      TextEditingController(text: "WASY100003");
  final TextEditingController passController =
      TextEditingController(text: "Asdf.1234");
  final AuthController authController = Get.find<AuthController>();

  final GlobalKey<FormState> _logKey = GlobalKey<FormState>();
  final List<GridItem> items = [
    GridItem(
      icon: AppIcons.profileIcon,
      text: 'nomineeLogin'.tr,
      onTap: null,
    ),
    GridItem(
      icon: AppIcons.propertyIcons,
      text: 'propertyDistribution'.tr,
      onTap: () {
        Get.to(() => PropertyDistributionScreen2(), preventDuplicates: false);
      },
    ),
    GridItem(
      icon: AppIcons.zakatIcons,
      text: 'zakatCalculation'.tr,
      onTap: () {
        Get.toNamed(AppRoutes.zakatCalculatorScreen, preventDuplicates: false);
      },
    ),
    GridItem(
      icon: AppIcons.contactIcons,
      text: 'contactUs'.tr,
      onTap: () {
        // Get.toNamed(AppRoutes.zakatCalculatorScreen, preventDuplicates: false);
      },
    ),
    GridItem(
      icon: AppIcons.helpsIcons,
      text: 'helps'.tr,
      onTap: () {
        //  Get.toNamed(AppRoutes.zakatCalculatorScreen, preventDuplicates: false);
      },
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: BackgroundImageContainer(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: _logKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      Center(
                          child: SvgPicture.asset(AppIcons.logo,
                              height: 160, width: 200)),
                      SizedBox(
                        height: 24,
                      ),

                      ///================3 Icon ==== Nominee === Finance === Application=================
                      SizedBox(
                        width: double.infinity,
                        height:
                            120, // Increased height to accommodate content
                        child: GridView.builder(
                          scrollDirection:
                              Axis.horizontal, // Enables horizontal scrolling
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, // Only one row
                            mainAxisSpacing:
                                4, // Spacing between items horizontally
                            childAspectRatio:
                                1 / 1.1, // Aspect ratio for each item
                          ),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return GestureDetector(
                              onTap: item.onTap,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(item.icon,
                                      height: 60, width: 60),
                                  SizedBox(height: 4),
                                  CustomText(text: item.text),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      ///=============Email====================
                      SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text: 'enterYourName'.tr,
                        color: AppColors.hitTextColor000000,
                        fontsize: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: CustomTextField(
                          controller: emailController,
                          hintText: 'enterYourName'.tr,
                          borderColor: AppColors.secondaryPrimaryColor,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 16, right: 12),
                            child: SvgPicture.asset(AppIcons.email,
                                color: AppColors.primaryColor,
                                height: 20,
                                width: 20),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enterUserNameError'.tr;
                            }
                            return null;
                          },
                        ),
                      ),

                      ///=============Password====================
                      SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text: 'enterYourPass'.tr,
                        color: AppColors.hitTextColor000000,
                        fontsize: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: CustomTextField(
                          controller: passController,
                          isPassword: true,
                          hintText: 'enterYourPass'.tr,
                          borderColor: AppColors.secondaryPrimaryColor,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 16, right: 12),
                            child: SvgPicture.asset(AppIcons.passIcon,
                                color: AppColors.primaryColor,
                                height: 24,
                                width: 24),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enterPassError'.tr;
                            } else if (value.length < 8 ||
                                !AppConstants.validatePassword(value)) {
                              return 'passValidationError'.tr;
                            }
                            return null;
                          },
                        ),
                      ),

                      ///=============Forgot====================
                      InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.forgotPassScreen,
                                parameters: {'email': emailController.text});
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 190),
                            child: CustomText(
                              text: 'forgotPass'.tr,
                              fontsize: 16,
                              color: AppColors.primaryColor,
                              textAlign: TextAlign.right,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),

                      ///=============Sign In Button====================
                      Obx(
                        () => CustomButtonCommon(
                          loading: authController.signInLoading.value == true,
                          title: 'signIn'.tr,
                          onpress: () {
                            if (_logKey.currentState!.validate()) {
                              TextInput.finishAutofillContext();
                              authController.signInHandle(
                                  userName: emailController.text,
                                  password: passController.text);

                              //  Get.toNamed(AppRoutes.homeScreen,preventDuplicates: false);
                            }
                          },
                        ),
                      ),

                      ///=============SignUp====================
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () {
                                //  Get.toNamed(AppRoutes.otpVirifyScreen,preventDuplicates: false);
                              },
                              child: CustomText(
                                text: 'dontHaveAccount'.tr,
                                fontsize: 20,
                              )),
                          InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.registrationScreen,
                                    preventDuplicates: false);
                              },
                              child: CustomText(
                                text: 'registerButton'.tr,
                                fontsize: 20,
                                color: AppColors.primaryColor,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GridItem {
  final String icon;
  final String text;
  final VoidCallback? onTap;

  GridItem({required this.icon, required this.text, this.onTap});
}
