
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/utils.dart';

import '../../../widgets/widgets.dart';


class AddOutsideWitness extends StatelessWidget {
   AddOutsideWitness({super.key});

  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: "Outside Witness".tr,fontsize: 18.sp,),),
      body: BackgroundImageContainer(
        child: Container(
          height: Get.height,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h,),
            
                  ///=============Last Name====================
                  SizedBox(height: 16.h,),
                  CustomText(text: "Relation with Witness".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller:  secondNameController,
                      hintText: "Relation with Witness".tr,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Relation with Witness'.tr;
                        }
                        return null;
            
                      },
                    ),
                  ),
             ///=============Last Name====================
                  SizedBox(height: 16.h,),
                  CustomText(text: "Name".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller:  secondNameController,
                      hintText: "Name".tr,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter your Name'.tr;
                        }
                        return null;

                      },
                    ),
                  ),

            
                  ///=============Mobile====================
                  SizedBox(height: 16.h,),
                  CustomText(text: "Mobile".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller:  mobileController,
                      hintText: "Mobile".tr,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter your Mobile Number'.tr;
                        }
                        return null;
            
                      },
                    ),
                  ),
            
            
            
                  ///=============Email====================
                  SizedBox(height: 16.h,),
                  CustomText(text: "email".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller:  emailController,
                      hintText: AppString.enterYourEmail.tr,
                      borderColor: AppColors.secondaryPrimaryColor,
                      // prefixIcon: Padding(
                      //   padding: EdgeInsets.only(left: 16.w, right: 12.w),
                      //   child: SvgPicture.asset(AppIcons.email, color:
                      //   AppColors.primaryColor, height: 20.h, width: 20.w),
                      // ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter your Email'.tr;
                        }else if(!AppConstants.emailValidate.hasMatch(value)){
                          return "Invalid Email".tr;
                        }
                        return null;
            
                      },
                    ),
                  ),


                  ///============Present Address"===================
                  SizedBox(height: 16.h,),
                  CustomText(text: "Present Address".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller:  secondNameController,
                      hintText: "Present Address".tr,
                      maxLine: 4,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Present Address'.tr;
                        }
                        return null;

                      },
                    ),
                  ),
 ///============Permanent Address"===================
                  SizedBox(height: 16.h,),
                  CustomText(text: "Permanent Address".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller:  secondNameController,
                      hintText: "Permanent Address".tr,
                      maxLine: 4,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Permanent Address'.tr;
                        }
                        return null;

                      },
                    ),
                  ),

                  SizedBox(height: 10,),
                  CustomButtonCommon(title: "Submit", onpress: (){}),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
