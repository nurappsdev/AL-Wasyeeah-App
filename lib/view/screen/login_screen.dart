
import 'package:al_wasyeah/utils/app_image.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/utils.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();
   final GlobalKey<FormState> _logKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: BackgroundImageContainer(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
          child: SingleChildScrollView(
            child: Form(
              key: _logKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80.h,),
                  Center(child: SvgPicture.asset(AppIcons.logo, height: 160.h, width: 200.w)),
                  SizedBox(height: 24.h,),

                  ///================3 Icon ==== Nominee === Finance === Application=================
                  SizedBox(
                    width: double.infinity,
                    height: 100.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppIcons.profileIcon, height: 60.h, width: 60.w),
                            SizedBox(height: 4.h,),
                            CustomText(text: "Nominee Log in",)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppIcons.financeIcon, height: 60.h, width: 60.w),
                            SizedBox(height: 4.h,),
                            CustomText(text: "Finance",)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppIcons.applicationIcon, height: 60.h, width: 60.w),
                            SizedBox(height: 4.h,),
                            CustomText(text: "Application",)
                          ],
                        ),
                      ],
                    ),
                  ),



                  ///=============Email====================
                  SizedBox(height: 20.h,),
                  CustomText(text: "Email",color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller:  emailController,
                      hintText: AppString.enterYourEmail,
                      borderColor: AppColors.secondaryPrimaryColor,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 12.w),
                        child: SvgPicture.asset(AppIcons.email, color:
                        AppColors.primaryColor, height: 20.h, width: 20.w),
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter your Email';
                        }else if(!AppConstants.emailValidate.hasMatch(value)){
                          return "Invalid Email";
                        }
                        return null;

                      },
                    ),
                  ),




                  ///=============Password====================
                  SizedBox(height: 20.h,),
                  CustomText(text: "Password",color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller:  passController,
                      isPassword: true,
                      hintText: AppString.enterYourPass,
                      borderColor: AppColors.secondaryPrimaryColor,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 12.w),
                        child: SvgPicture.asset(AppIcons.passIcon, color: AppColors.primaryColor, height: 24.h, width: 24.w),
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter your Password';
                        }else if(value.length < 8 || !AppConstants.validatePassword(value)){
                          return "Password: 8 characters min, letters & digits \nrequired";
                        }
                        return null;

                      },
                    ),
                  ),



                  ///=============Forgot====================
                  InkWell(
                      onTap: (){
                        // Get.toNamed(AppRoutes.forgotPassScreen,
                        //     parameters: {
                        //       'email': emailController.text
                        //     }
                        // );

                      },
                      child: Padding(
                        padding:  EdgeInsets.only(left: 190.w ),
                        child: CustomText(text: AppString.forgotPass, fontsize:16.sp,color: AppColors.primaryColor,textAlign: TextAlign.right,fontWeight: FontWeight.w500,),
                      )),
                  SizedBox(height: 20.h,),




                  ///=============Sign In Button====================
                  CustomButtonCommon(
               // loading: authController.loadingLoading.value == true,
                title: AppString.signIn,
                onpress: () {
                  if (_logKey.currentState!.validate()) {
                    // authController.loginHandle(
                    //     emailController.text, passController.text);
                  }
                },),




                  ///=============SignUp====================
                  SizedBox(height: 20.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: (){
                          //  Get.toNamed(AppRoutes.otpVirifyScreen,preventDuplicates: false);
                          },
                          child: CustomText(text: AppString.dontHaveAccount, fontsize: 20.sp,)),
                      InkWell(
                          onTap: (){
                       //     Get.toNamed(AppRoutes.signUpScreen);
                          },
                          child: CustomText(text: AppString.signUpButton, fontsize: 20.sp,color: AppColors.primaryColor,)),
                    ],
                  ),




                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
