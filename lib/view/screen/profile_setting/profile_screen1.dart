
import 'dart:io';

import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/controllers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
import 'dart:typed_data';


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
Uint8List? _image;
File? selectedIMage;

///----------------TN image=============================
File? selectedImages;
String? imagePath; // Variable to store the image path
String get displayImagePath {
  if (imagePath == null || imagePath!.length <= 30) {
    return imagePath ?? 'No image selected';
  }
  return imagePath!.substring(imagePath!.length - 30); // Get the last 18 characters
}
Future<void> _TNImageFromGallery() async {
  final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedImage == null) return;

  setState(() {
    selectedImages = File(pickedImage.path);
    imagePath = pickedImage.path; // Save the image path
  });

}


///----------------NID image=============================
File? nIDImages;
String? nidImagePath; // Variable to store the image path
String get displayImageNIDPath {
  if (nidImagePath == null || nidImagePath!.length <= 30) {
    return nidImagePath ?? 'No image selected';
  }
  return nidImagePath!.substring(nidImagePath!.length - 30); // Get the last 18 characters
}
Future<void> _NIDImageFromGallery() async {
  final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedImage == null) return;

  setState(() {
    nIDImages = File(pickedImage.path);
    nidImagePath = pickedImage.path; // Save the image path
  });

}
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Expanded(
                  child: CustomTextField(
                    controller:  passOrNIDController,
                    hintText: "NID/Passport No".tr,
                    borderColor: AppColors.secondaryPrimaryColor,
                    onChange: (value){},
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'NID/Passport No'.tr;
                      }
                      return null;

                    },
                  ),
                ),
                SizedBox(width: 6.w,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: IconButton(
                    icon:Icon(Icons.attach_file_outlined,color: AppColors.primaryColor,),
                    onPressed: () {
                      _NIDImageFromGallery();
                      // Add your action here
                    },
                  ),
                ),
              ],
            ),
              SizedBox(height: 6.w,),
              if (nIDImages != null)
                Text(
                  'Image Path: ${displayImageNIDPath.toString()}',
                  style: TextStyle(color: Colors.grey),
                ),
              SizedBox(height: 16.h),
              ///============TIN (Tax Identification Number)====================
              CustomText(text: "TIN (Tax Identification Number)".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child:
                    Column(children: [
                      CustomTextField(
                        controller:  passOrNIDController,
                        hintText: "TIN (Tax Identification Number)".tr,
                        borderColor: AppColors.secondaryPrimaryColor,
                      ),
                    ],)

                  ),
                  SizedBox(width: 6.w,),
                Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: IconButton(
                        icon:Icon(Icons.attach_file_outlined,color: AppColors.primaryColor,),
                        onPressed: () {
                          _TNImageFromGallery();
                          // Add your action here
                        },
                      ),

                  ),
                ],
              ),
              SizedBox(height: 6.w,),
              if (selectedImages != null)
                Text(
                  'Image Path: ${displayImagePath.toString()}',
                  style: TextStyle(color: Colors.grey),
                ),
              SizedBox(height: 16.h),

              ///============Photo====================
              CustomText(text: "Photo".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
              SizedBox(height: 10.h,),
              GestureDetector(
                onTap: (){
                  showImagePickerOption(context);

                },
                child: Container(
                  width: double.infinity, // Set your desired width here
                  height: 160.h, // Set your desired height here
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.dm),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: selectedIMage == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: Colors.green,
                        size: 40,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Take Your Photo".tr,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                      :
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.dm),
                    child: selectedIMage!.path.isNotEmpty
                        ? Image.file(
                      selectedIMage!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    )
                        :   CustomNetworkImage(
                      boxShape: BoxShape.rectangle,
                      imageUrl: "",
                      height: 180.h,
                      width: 345.w,
                    ) ,
                  ),
                ),
              ),

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
//==================================> ShowImagePickerOption Function <===============================
void showImagePickerOption(BuildContext context) {
  showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 6.2,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromGallery();

                      // _pickImageFromGallery();
                    },
                    child: SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 50.w,
                          ),
                          CustomText(text: 'Gallery')
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromCamera();

                      // _pickImageFromCamera();
                    },
                    child: SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 50.w,
                          ),
                          CustomText(text: 'Camera')
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}


//==================================> Gallery <===============================
Future _pickImageFromGallery() async {
  final returnImage =
  await ImagePicker().pickImage(source: ImageSource.gallery);
  if (returnImage == null) return;
  setState(() {
    selectedIMage = File(returnImage.path);
    _image = File(returnImage.path).readAsBytesSync();
  });
  Get.back();
}

//==================================> Camera <===============================
  Future _pickImageFromCamera() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Get.back();
  }


}