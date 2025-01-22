
import 'package:al_wasyeah/helpers/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../utils/utils.dart';
import '../widgets/widgets.dart';
class ForgotPassScreen extends StatefulWidget {
  ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final GlobalKey<FormState> _logRegKey = GlobalKey<FormState>();

   TextEditingController firstNameController = TextEditingController();

   TextEditingController secondNameController = TextEditingController();

   TextEditingController mobileController = TextEditingController();

   TextEditingController emailController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();

   Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
     DateTime? pickedDate = await showDatePicker(
       context: context,
       initialDate: DateTime.now(),
       firstDate: DateTime(2000),
       lastDate: DateTime(2100),
     );
     if (pickedDate != null) {
       setState(() {
         controller.text = DateFormat('MM/dd/yyyy').format(pickedDate);
       });
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  CustomText(text: "Forgot Password".tr,fontsize: 18.sp,),),
      body: BackgroundImageContainer(
        child: Container(
          height: Get.height,
          width: double.infinity,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
            child: SingleChildScrollView(
              child: Form(
                key: _logRegKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.h,),
                    Center(child: SvgPicture.asset(AppIcons.logo, height: 100.h, width: 140.w)),
                    SizedBox(height: 30.h,),
                    Center(child: CustomText(text: "Forgot Password".tr,fontsize: 20.sp,textAlign: TextAlign.center,fontWeight: FontWeight.w600,)),
                    SizedBox(height: 16.h,),
                    Center(child: CustomText(text: "Don’t worry! it happens Please enter the address associate with your account.".tr,maxline: 2, fontsize: 14.sp,textAlign: TextAlign.center,)),

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
                            return 'Please enter your Mobile Number';
                          }
                          return null;

                        },
                      ),
                    ),



                    ///=============Email====================
                    SizedBox(height: 20.h,),
                    CustomText(text: "email".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
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
                        controller: startDateController,
                        readOnly: true,
                        hintText: "Date of birth".tr,
                        hintextColor: Colors.black54,
                        borderColor: AppColors.secondaryPrimaryColor,
                        onTap: () => _selectDate(context, startDateController),
                        suffixIcon: Icon(Icons.calendar_month,color: AppColors.primaryColor,),
                        validator: (value){
                          // if(value == null || value.isEmpty){
                          //   return 'Please enter a title';
                          // }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),

                    ///=============Sign In Button====================
                    CustomButtonCommon(
                      // loading: authController.loadingLoading.value == true,
                      title: "Submit".tr,
                      onpress: () {

                        // if (_logRegKey.currentState!.validate()) {
                        //
                        //   // authController.loginHandle(
                        //   //     emailController.text, passController.text);
                        // }
                      },),

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
