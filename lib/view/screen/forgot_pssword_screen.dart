import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../utils/utils.dart';

import '../widgets/widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
   ForgotPasswordScreen({super.key});
   final GlobalKey<FormState> _forRegKey = GlobalKey<FormState>();
   TextEditingController firstNameController = TextEditingController();
   TextEditingController secondNameController = TextEditingController();
   TextEditingController mobileController = TextEditingController();
   TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImageContainer(
        child: Container(
          height: Get.height,
          width: double.infinity,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
            child: SingleChildScrollView(
              child: Form(
                key: _forRegKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.h,),
                    Center(child: SvgPicture.asset(AppIcons.logo, height: 100.h, width: 140.w)),
                    SizedBox(height: 30.h,),
                    Center(child: CustomText(text: "Registration",fontsize: 18.sp,textAlign: TextAlign.center,)),
                    SizedBox(height: 16.h,),
                    Center(child: CustomText(text: "Enter your details to register Al Wasyyah",fontsize: 16.sp,textAlign: TextAlign.center,)),


                    ///=============First Name====================
                    SizedBox(height: 20.h,),
                    CustomText(text: "First Name*",color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                    SizedBox(height: 10.h,),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomTextField(
                        controller:  firstNameController,
                        hintText: "First Name",
                        borderColor: AppColors.secondaryPrimaryColor,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter your First Name';
                          }
                          return null;

                        },
                      ),
                    ),


                    ///=============Last Name====================
                    SizedBox(height: 16.h,),
                    CustomText(text: "Last Name*",color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                    SizedBox(height: 10.h,),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomTextField(
                        controller:  secondNameController,
                        hintText: "Last Name",
                        borderColor: AppColors.secondaryPrimaryColor,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter your Last Name';
                          }
                          return null;

                        },
                      ),
                    ),


                    ///=============Mobile====================
                    SizedBox(height: 16.h,),
                    CustomText(text: "Mobile*",color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                    SizedBox(height: 10.h,),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomTextField(
                        controller:  mobileController,
                        hintText: "Mobile",
                        borderColor: AppColors.secondaryPrimaryColor,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter your Mobile Number';
                          }
                          return null;

                        },
                      ),
                    ),



                    ///=============Email====================
                    SizedBox(height: 16.h,),
                    CustomText(text: "Email*",color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                    SizedBox(height: 10.h,),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomTextField(
                        controller:  emailController,
                        hintText: AppString.enterYourEmail,
                        borderColor: AppColors.secondaryPrimaryColor,
                        // prefixIcon: Padding(
                        //   padding: EdgeInsets.only(left: 16.w, right: 12.w),
                        //   child: SvgPicture.asset(AppIcons.email, color:
                        //   AppColors.primaryColor, height: 20.h, width: 20.w),
                        // ),
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



                    ///=============Sign In Button====================
                    CustomButtonCommon(
                      // loading: authController.loadingLoading.value == true,
                      title: AppString.signUpButton,
                      onpress: () {
                        if (_forRegKey.currentState!.validate()) {
                          // authController.loginHandle(
                          //     emailController.text, passController.text);
                        }
                      },),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
