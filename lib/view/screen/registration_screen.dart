import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/controllers.dart';
import '../../helpers/helpers.dart';
import '../../utils/utils.dart';

import '../widgets/widgets.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
   final GlobalKey<FormState> _forRegKey = GlobalKey<FormState>();

   TextEditingController firstNameController = TextEditingController();

   TextEditingController secondNameController = TextEditingController();

   TextEditingController mobileController = TextEditingController();

   TextEditingController emailController = TextEditingController();

   TextEditingController dateOfBirthController = TextEditingController();

   TextEditingController securityController = TextEditingController();

   AuthController  authController = Get.put(AuthController());

  String? _selectedQuestionId;

  DateTime? birthDate;

  @override
  void dispose() {
    firstNameController.dispose();
    secondNameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    dateOfBirthController.dispose();
    securityController.dispose();
    super.dispose();
  }
   @override
   void initState() {
     super.initState();
     authController.getSecurityQuestion();
   }


   @override
  Widget build(BuildContext context) {

    print(authController.securityQuestionResponseModel.length);
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
                    Center(child: CustomText(text: "Registration".tr,fontsize: 28.sp,textAlign: TextAlign.center,)),
                    // SizedBox(height: 16.h,),
                    // Center(child: CustomText(text: "Enter your details to register Al Wasyyah",fontsize: 16.sp,textAlign: TextAlign.center,)),

                    SizedBox(height: 16.h,),
                    CustomText(text: "First Name".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                    SizedBox(height: 10.h,),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomTextField(
                        controller:  firstNameController,
                        hintText: "First Name".tr,
                        borderColor: AppColors.secondaryPrimaryColor,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter your First Name'.tr;
                          }
                          return null;

                        },
                      ),
                    ),



                    ///=============Last Name====================
                    SizedBox(height: 16.h,),
                    CustomText(text: "Last Name".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                    SizedBox(height: 10.h,),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomTextField(
                        controller:  secondNameController,
                        hintText: "Last Name".tr,
                        borderColor: AppColors.secondaryPrimaryColor,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter your Last Name'.tr;
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
                        keyboardType: TextInputType.number,
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



                    ///==========================Date of birth*==========================
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
                    SizedBox(height: 10.h),
                    CustomText(text: "Security Question".tr,
                      fontsize: 16.sp,
                      color: AppColors.hitTextColor000000,
                      textAlign: TextAlign.left,

                    ),
                    SizedBox(height: 10.h),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.secondaryPrimaryColor),borderRadius: BorderRadius.circular(14.r)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:  AppColors.secondaryPrimaryColor,),borderRadius: BorderRadius.circular(14.r)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(16.r)
                        ),

                      ),
                      isExpanded: true,
                      hint: CustomText(text: "select Your Question"),
                      value: _selectedQuestionId,
                      items: authController.securityQuestionResponseModel
                          .map((model) => DropdownMenuItem<String>(
                        value: model.questionId.toString(),
                        child: Text(model.questionText.toString()),

                      ))
                          .toList(),
                      onChanged: (value) {
                         _selectedQuestionId = value;
                         print(_selectedQuestionId);
                      },
                    ),
                    SizedBox(height: 10.h),
                    ///=============Answer====================
                    SizedBox(height: 16.h,),
                    CustomText(text: "Answer".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                    SizedBox(height: 10.h,),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomTextField(
                        controller:  securityController,
                        hintText: "Answer".tr,
                        borderColor: AppColors.secondaryPrimaryColor,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter your Answer'.tr;
                          }
                          return null;

                        },
                      ),
                    ),



                    ///=============Sign In Button====================
                    Obx(()=>
                 CustomButtonCommon(
                         loading: authController.signUpLoading.value == true,
                        title: AppString.registerButton.tr,
                        onpress: () {
                         // Get.toNamed(AppRoutes.otpScreen,preventDuplicates: false);
                          if (_forRegKey.currentState!.validate()) {
                            authController.signUpHandle(
                              firstName: firstNameController.text,
                                lastName: secondNameController.text,
                                email: emailController.text,
                                mobile: mobileController.text,
                                dob: dateOfBirthController.text,
                                securityAnswer: securityController.text,
                                source: "mobile",
                                securityCode: _selectedQuestionId.toString(),
                                userTypeId: "2"

                            );
                          }
                        },),
                    ),
                    SizedBox(height: 20.h,),

                    ///=============SignUp====================
                    SizedBox(height: 16.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: (){
                              //  Get.toNamed(AppRoutes.otpVirifyScreen,preventDuplicates: false);
                            },
                            child: CustomText(text: "Already have an account? ".tr, fontsize: 18.sp,)),
                        InkWell(
                            onTap: (){
                              Get.toNamed(AppRoutes.loginScreen,preventDuplicates: false);
                            },
                            child: CustomText(text:AppString.signIn.tr, fontsize: 18.sp,color: AppColors.primaryColor,)),
                      ],
                    ),
                    SizedBox(height: 20.h,),

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
