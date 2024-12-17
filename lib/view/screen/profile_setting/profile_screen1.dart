
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class ProfileScreen1 extends StatefulWidget {


  ProfileScreen1();

  @override
  State<ProfileScreen1> createState() => _ProfileScreen1State();
}

class _ProfileScreen1State extends State<ProfileScreen1> {
ProfileController profileController = Get.put(ProfileController());
final List<Map<String, String>> muslimCountriesInWorld = [
  {'name': 'Palestine', 'flag': 'PS'}, // Palestine
  {'name': 'Lebanon', 'flag': 'LB'}, // Lebanon
  {'name': 'Jordan', 'flag': 'JO'}, // Jordan
  {'name': 'Syria', 'flag': 'SY'}, // Syria
  {'name': 'Saudi Arabia', 'flag': 'SA'}, // Saudi Arabia
  {'name': 'United Arab Emirates', 'flag': 'AE'}, // UAE
  {'name': 'Oman', 'flag': 'OM'}, // Oman
  {'name': 'Qatar', 'flag': 'QA'}, // Qatar
  {'name': 'Bahrain', 'flag': 'BH'}, // Bahrain
  {'name': 'Kuwait', 'flag': 'KW'}, // Kuwait
  {'name': 'Iraq', 'flag': 'IQ'}, // Iraq
  {'name': 'Turkey', 'flag': 'TR'}, // Turkey
  {'name': 'Afghanistan', 'flag': 'AF'}, // Afghanistan
  {'name': 'Pakistan', 'flag': 'PK'}, // Pakistan
  {'name': 'Indonesia', 'flag': 'ID'}, // Indonesia
  {'name': 'Malaysia', 'flag': 'MY'}, // Malaysia
  {'name': 'Brunei', 'flag': 'BN'}, // Brunei
  {'name': 'Kazakhstan', 'flag': 'KZ'}, // Kazakhstan
  {'name': 'Turkmenistan', 'flag': 'TM'}, // Turkmenistan
  {'name': 'Uzbekistan', 'flag': 'UZ'}, // Uzbekistan
  {'name': 'Kyrgyzstan', 'flag': 'KG'}, // Kyrgyzstan
  {'name': 'Tajikistan', 'flag': 'TJ'}, // Tajikistan
  {'name': 'Maldives', 'flag': 'MV'}, // Maldives
  {'name': 'Algeria', 'flag': 'DZ'}, // Algeria
  {'name': 'Egypt', 'flag': 'EG'}, // Egypt
  {'name': 'Morocco', 'flag': 'MA'}, // Morocco
  {'name': 'Tunisia', 'flag': 'TN'}, // Tunisia
  {'name': 'Libya', 'flag': 'LY'}, // Libya
  {'name': 'Sudan', 'flag': 'SD'}, // Sudan
  {'name': 'Somalia', 'flag': 'SO'}, // Somalia
  {'name': 'Nigeria', 'flag': 'NG'}, // Nigeria
  {'name': 'Senegal', 'flag': 'SN'}, // Senegal
  {'name': 'Mali', 'flag': 'ML'}, // Mali
  {'name': 'Chad', 'flag': 'TD'}, // Chad
  {'name': 'Mauritania', 'flag': 'MR'}, // Mauritania
  {'name': 'Gambia', 'flag': 'GM'}, // Gambia
  {'name': 'Comoros', 'flag': 'KM'}, // Comoros
  {'name': 'Sierra Leone', 'flag': 'SL'}, // Sierra Leone
  {'name': 'Guinea', 'flag': 'GN'}, // Guinea
  {'name': 'Indonesia', 'flag': 'ID'}, // Indonesia
  {'name': 'Bangladesh', 'flag': 'BD'}, // Bangladesh
  {'name': 'India', 'flag': 'IN'}, // India (significant Muslim population)
  {'name': 'Russia', 'flag': 'RU'}, // Russia (significant Muslim population)
  {'name': 'Philippines', 'flag': 'PH'}, // Philippines (significant Muslim population)
];
String _selectedCountry = 'Bangladesh';
TextEditingController districtController = TextEditingController();
TextEditingController passOrNIDController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    body: Container(
      height: Get.height,
      width: double.infinity,
      child: Padding(
        padding:EdgeInsets.symmetric(horizontal: 14.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h,),
              SizedBox(height: 10.h,),
              ///=============Gender====================
              CustomDropdown(label: "Gender".tr,items: profileController.gender,selectedValue: profileController.selectedGender,),
              ///=============Marital Status====================
              CustomDropdown(label: "Marital Status".tr,items: profileController.maritalStatus,selectedValue: profileController.selectedMarried,),
              SizedBox(height: 10.h,),
              ///=============Profession====================
              CustomDropdown(label: "Profession".tr,items: profileController.profession,selectedValue: profileController.selectedProfession,),
          
              ///=============District/State====================
              SizedBox(height: 16.h,),
              CustomText(text: "District/State".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
              SizedBox(height: 10.h,),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: CustomTextField(
                  controller:  districtController,
                  hintText: "District/State".tr,
                  borderColor: AppColors.secondaryPrimaryColor,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'District/State'.tr;
                    }
                    return null;
          
                  },
                ),
              ),
              SizedBox(height: 16.h),
              ///============NID/PASSPORT No*====================
              CustomText(text: "NID/Passport No".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
              SizedBox(height: 10.h,),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: CustomTextField(
                  controller:  passOrNIDController,
                  hintText: "NID/Passport No".tr,
                  borderColor: AppColors.secondaryPrimaryColor,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'NID/Passport No'.tr;
                    }
                    return null;

                  },
                ),
              ),
              SizedBox(height: 16.h),

              ///=============Place of birth====================
              CustomText(text: "Place of birth".tr,fontsize: 16.sp,),
              SizedBox(height: 10.h),
          
              Center(
                child: Container(
                  height: 50.h, // Adjust the height here
                  width: 250.w, // Full width
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r), // Rounded corners
                    border: Border.all(color: Colors.grey), // Border styling
                    color: Colors.white, // Background color
                  ),
                  child: DropdownButton<String>(
          
                    value: _selectedCountry,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCountry = newValue!;
                      });
                    },
                    underline: SizedBox.shrink(), // Remove the default underline
                    items: muslimCountriesInWorld.map<DropdownMenuItem<String>>((country) {
                      return DropdownMenuItem<String>(
                        value: country['name'],
                        child: SingleChildScrollView( // Make the content scrollable if needed
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,  // Ensure it only takes up needed space
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Properly space elements
                            crossAxisAlignment: CrossAxisAlignment.center,  // Align items centrally
                            children: [
                              // Country name
                              Text(
                                country['name']!,
                                overflow: TextOverflow.ellipsis,  // Prevent overflow of text
                              ),
                              SizedBox(width: 10.w),  // Space between text and flag
                              // Country flag
                              CountryFlag.fromCountryCode(
                                country['flag']!,
                                width: 24.w,  // Adjust the width of the flag
                                height: 24.h, // Adjust the height of the flag
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              SizedBox(height: 10.h),

              ///=============Button====================
              CustomButtonCommon(
                // loading: authController.loadingLoading.value == true,
                title: "Submit".tr,
                onpress: () {
              //    Get.toNamed(AppRoutes.otpScreen,preventDuplicates: false);
                  // if (_forRegKey.currentState!.validate()) {
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
    );
  }
}