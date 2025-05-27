
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/controllers.dart';
import '../../../../utils/utils.dart';

import '../../../widgets/widgets.dart';


class AddOutsideWitness extends StatelessWidget {
   AddOutsideWitness({super.key});

  TextEditingController relNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
   TextEditingController dateOfBirthController = TextEditingController();

   TextEditingController presentAddressController = TextEditingController();

   TextEditingController permanentAddressController = TextEditingController();
   DateTime? birthDate;
   NomineeController nomineeController = Get.put(NomineeController());
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
              child: Form(
                key: _formKey,
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
                        controller: relNameController,
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
                        controller:  nameController,
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
                    SizedBox(height: 20.h,),
                    CustomText(text: "Date of birth".tr,
                      fontsize: 16.sp,
                      color: AppColors.hitTextColor000000,
                      textAlign: TextAlign.left,

                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomTextField(
                        controller: dateOfBirthController,
                        readOnly: true,
                        hintText: "Date of birth".tr,
                        hintextColor: Colors.black54,
                        borderColor: AppColors.secondaryPrimaryColor,
                        onTap: () async{
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1930),
                            lastDate: DateTime.now(),
                          );

                          if (selectedDate != null) {
                            birthDate = selectedDate;
                            dateOfBirthController.text = DateFormat('yyyy-MM-dd').format(birthDate!);
                          }
                          print(dateOfBirthController.text);
                        },
                        suffixIcon: Icon(Icons.calendar_month,color: AppColors.primaryColor,),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please Write Date of birth'.tr;
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
                        controller: presentAddressController,
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
                        controller:  permanentAddressController,
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
                    Obx(()=>

                      CustomButtonCommon(
                        loading: nomineeController.addNomineeLoading.value == true,
                          title: "Submit", onpress: (){
                        if(_formKey.currentState!.validate()){
                          nomineeController.addNomineeAndWitness(
                              isNomineeTrue: false,
                              userName: nameController.text,
                              mobileNo: mobileController.text,
                              email: emailController.text,
                              relationWithUser: relNameController.text,
                              dob: dateOfBirthController.text,
                              presentAddress: presentAddressController.text,
                              permanentAddress: permanentAddressController.text
                          );
                        }
                      }

                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}
