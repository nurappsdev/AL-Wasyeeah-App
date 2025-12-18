import 'dart:developer';
import 'dart:io';

import 'package:al_wasyeah/main.dart';
import 'package:al_wasyeah/models/profile_info_model/country_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/gender_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/marital_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/profession_list_model.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:country_flags/country_flags.dart';
import 'package:dropdown_search/dropdown_search.dart';
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
  ProfileController controller = Get.put(ProfileController());
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
    {
      'name': 'Philippines',
      'flag': 'PH'
    }, // Philippines (significant Muslim population)
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
    return imagePath!
        .substring(imagePath!.length - 30); // Get the last 18 characters
  }

  Future<void> _TNImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
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
    return nidImagePath!
        .substring(nidImagePath!.length - 30); // Get the last 18 characters
  }

  Future<void> _NIDImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    setState(() {
      nIDImages = File(pickedImage.path);
      nidImagePath = pickedImage.path; // Save the image path
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Container(
          height: Get.height,
          width: double.infinity,
          child: controller.status.value.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.hitTextColor000000,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.h),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.getProfilePageData();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "First Name".tr,
                            color: AppColors.hitTextColor000000,
                            fontsize: 16.sp,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),

                          /// =============First Name====================
                          CustomTextFormField(
                            controller: controller.firstNameController.value,
                            hint: "First Name".tr,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "First Name is required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 16.h,
                          ),

                          /// =============Last Name====================
                          CustomText(
                            text: "Last Name".tr,
                            color: AppColors.hitTextColor000000,
                            fontsize: 16.sp,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          CustomTextFormField(
                            controller: controller.lastNameController.value,
                            hint: "Last Name".tr,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Last Name is required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 16.h,
                          ),

                          ///=============Marital Status====================
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Marital Status".tr,
                                color: AppColors.hitTextColor000000,
                                fontsize: 16.sp,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              CustomDropdown<MaritalModel>(
                                hint: "Select Marital Status",
                                items: controller.maritalList,
                                value: controller.selectedMarried.value,
                                itemToString: (item) => item.maritalType ?? "",
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 16.h,
                          ),

                          ///=============Profession====================

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Profession".tr,
                                color: AppColors.hitTextColor000000,
                                fontsize: 16.sp,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              CustomDropdown<ProfessionModel>(
                                hint: "Select Profession",
                                items: controller.professionList,
                                value: controller.selectedProfession.value,
                                itemToString: (item) => item.profession ?? "",
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),

                          ///=============Place of Birth====================
                          CustomText(
                            text: "Place of Birth".tr,
                            color: AppColors.hitTextColor000000,
                            fontsize: 20.sp,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          CustomDropdown<CountryModel>(
                            hint: "Select Country",
                            items: controller.countryList,
                            value: controller.selectedCountry.value,
                            itemToString: (item) => item.country ?? "",
                          ),
                          SizedBox(
                            height: 16.h,
                          ),

                          /// =============District/State====================
                          CustomText(
                            text: "District/State".tr,
                            color: AppColors.hitTextColor000000,
                            fontsize: 16.sp,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          CustomTextFormField(
                            controller: controller.districtController.value,
                            hint: "District/State".tr,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "District/State is required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 16.h,
                          ),

                          ///=============Gender====================
                          CustomText(
                            text: "Gender".tr,
                            color: AppColors.hitTextColor000000,
                            fontsize: 20.sp,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          CustomDropdown<GenderModel>(
                            hint: "Select Gender",
                            items: controller.genderList,
                            value: controller.selectedGender.value,
                            itemToString: (item) => item.gender ?? "",
                          ),
                          SizedBox(
                            height: 16.h,
                          ),

                          ///============NID/PASSPORT No*====================
                          CustomText(
                            text: "NID/Passport No".tr,
                            color: AppColors.hitTextColor000000,
                            fontsize: 20.sp,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),

                          CustomTextFormField(
                            controller: controller.nidController.value,
                            hint: "NID/Passport No".tr,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "NID/Passport No is required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),

                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Container(
                                      child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor:
                                                AppColors.hitTextColor000000,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                            side: BorderSide(
                                              color: AppColors.primaryColor,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: Text("Choose file"))),
                                ),
                                SizedBox(width: 6.w),
                                InkWell(
                                  onTap: controller.isDownloadingNid.value
                                      ? null
                                      : () => controller.downloadNidFile(),
                                  child: Container(
                                    width: 48.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: controller.isDownloadingNid.value
                                        ? Center(
                                            child: SizedBox(
                                              width: 22.w,
                                              height: 22.w,
                                              child: CircularProgressIndicator(
                                                value: controller
                                                        .nidDownloadProgress
                                                        .value /
                                                    100,
                                                strokeWidth: 2,
                                                color: AppColors.whiteColor,
                                              ),
                                            ),
                                          )
                                        : Icon(
                                            Icons.download,
                                            color: AppColors.whiteColor,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomText(
                            text: "* Only Pdf,JPEG,PNG file are allowed".tr,
                            color: AppColors.redColor,
                            fontsize: 12.sp,
                          ),

                          SizedBox(
                            height: 6.w,
                          ),
                          if (nIDImages != null)
                            Text(
                              'Image Path: ${displayImageNIDPath.toString()}',
                              style: TextStyle(color: Colors.grey),
                            ),
                          SizedBox(height: 16.h),

                          ///============TIN (Tax Identification Number)====================
                          CustomText(
                            text: "TIN (Tax Identification Number)".tr,
                            color: AppColors.hitTextColor000000,
                            fontsize: 20.sp,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  CustomTextField(
                                    controller: passOrNIDController,
                                    hintText:
                                        "TIN (Tax Identification Number)".tr,
                                    borderColor:
                                        AppColors.secondaryPrimaryColor,
                                  ),
                                ],
                              )),
                              SizedBox(
                                width: 6.w,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.attach_file_outlined,
                                    color: AppColors.primaryColor,
                                  ),
                                  onPressed: () {
                                    _TNImageFromGallery();
                                    // Add your action here
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 6.w,
                          ),
                          if (selectedImages != null)
                            Text(
                              'Image Path: ${displayImagePath.toString()}',
                              style: TextStyle(color: Colors.grey),
                            ),
                          SizedBox(height: 16.h),

                          ///============Photo====================
                          CustomText(
                            text: "Photo".tr,
                            color: AppColors.hitTextColor000000,
                            fontsize: 20.sp,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              showImagePickerOption(context);
                            },
                            child: Container(
                              width: double
                                  .infinity, // Set your desired width here
                              height: 160.h, // Set your desired height here
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12.dm),
                                border:
                                    Border.all(color: Colors.green.shade200),
                              ),
                              child: selectedIMage == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                  : ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(12.dm),
                                      child: selectedIMage!.path.isNotEmpty
                                          ? Image.file(
                                              selectedIMage!,
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                            )
                                          : CustomNetworkImage(
                                              boxShape: BoxShape.rectangle,
                                              imageUrl: "",
                                              height: 180.h,
                                              width: 345.w,
                                            ),
                                    ),
                            ),
                          ),

                          ///=============Place of birth====================
                          CustomText(
                            text: "Place of birth".tr,
                            fontsize: 16.sp,
                          ),
                          SizedBox(height: 10.h),

                          Center(
                            child: Container(
                              height: 50.h, // Adjust the height here
                              width: 250.w, // Full width
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    50.r), // Rounded corners
                                border: Border.all(
                                    color: Colors.grey), // Border styling
                                color: Colors.white, // Background color
                              ),
                              child: DropdownButton<String>(
                                value: _selectedCountry,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedCountry = newValue!;
                                  });
                                },
                                underline: SizedBox
                                    .shrink(), // Remove the default underline
                                items: muslimCountriesInWorld
                                    .map<DropdownMenuItem<String>>((country) {
                                  return DropdownMenuItem<String>(
                                    value: country['name'],
                                    child: SingleChildScrollView(
                                      // Make the content scrollable if needed
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisSize: MainAxisSize
                                            .min, // Ensure it only takes up needed space
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween, // Properly space elements
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center, // Align items centrally
                                        children: [
                                          // Country name
                                          Text(
                                            country['name']!,
                                            overflow: TextOverflow
                                                .ellipsis, // Prevent overflow of text
                                          ),
                                          SizedBox(
                                              width: 10
                                                  .w), // Space between text and flag
                                          // Country flag
                                          CountryFlag.fromCountryCode(
                                            country['flag']!,
                                            width: 24
                                                .w, // Adjust the width of the flag
                                            height: 24
                                                .h, // Adjust the height of the flag
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
                            title: "Next".tr,
                            onpress: () {
                              //    Get.toNamed(AppRoutes.otpScreen,preventDuplicates: false);
                              // if (_forRegKey.currentState!.validate()) {
                              //   // authController.loginHandle(
                              //   //     emailController.text, passController.text);
                              // }
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      }),
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









// class MaritalStatusDropdown extends StatefulWidget {
//   const MaritalStatusDropdown({super.key});

//   @override
//   State<MaritalStatusDropdown> createState() => _MaritalStatusDropdownState();
// }

// class _MaritalStatusDropdownState extends State<MaritalStatusDropdown> {
//   final FocusNode _focusNode = FocusNode();

//   static const Color green = Color(0xFF1E9E5A);
//   static const TextStyle textStyle = TextStyle(
//     fontSize: 16,
//     fontWeight: FontWeight.w500,
//     color: Colors.black,
//   );

//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final profileController = Get.find<ProfileController>();

//     return Obx(() {
//       final selected = profileController.selectedMarried.value;
//       final bool isFocused = _focusNode.hasFocus;

//       return Focus(
//         focusNode: _focusNode,
//         onFocusChange: (_) => setState(() {}),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 160),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             boxShadow: isFocused
//                 ? [
//                     BoxShadow(
//                       color: green.withOpacity(0.25),
//                       blurRadius: 10,
//                       offset: const Offset(0, 3),
//                     ),
//                   ]
//                 : [],
//           ),
//           child: Stack(
//             children: [
//               // ✅ Internal left color strip (inside the border)
//               Positioned.fill(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: AnimatedContainer(
//                       duration: const Duration(milliseconds: 160),
//                       width: isFocused ? 4 : 0, // only on click
//                       color: green,
//                     ),
//                   ),
//                 ),
//               ),

//               // ✅ Actual dropdown
//               DropdownSearch<MaritalListModel>(
//                 items: (f, cs) => profileController.maritalList,
//                 selectedItem: selected,
//                 compareFn: (a, b) => a.maritalId == b.maritalId,

//                 popupProps: PopupProps.menu(
//                   showSearchBox: true,
//                   fit: FlexFit.loose,
//                   // itemBuilder: (context, item, isSelected) => Padding(
//                   //   padding:
//                   //       const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                   //   child: Text(item.maritalType ?? '', style: textStyle),
//                   // ),
//                 ),

//                 decoratorProps: DropDownDecoratorProps(
//                   decoration: InputDecoration(
//                     isDense: true,
//                     filled: true,
//                     fillColor: Colors.white,
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 12,
//                     ),

//                     // ✅ Border + shadow ONLY when focused
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: const BorderSide(color: Colors.grey, width: 1.2),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: const BorderSide(color: green, width: 1.6),
//                     ),
                    

//                     // hide default arrow
//                     suffixIcon: const SizedBox.shrink(),
//                   ),
//                 ),

//                 dropdownBuilder: (context, selectedItem) {
//                   final text = selectedItem?.maritalType ?? "Material Status";
//                   final color =
//                       selectedItem == null ? Colors.grey : Colors.black;

//                   return Padding(
//                     // ✅ add padding-left to avoid text touching the green strip
//                     padding: EdgeInsets.only(left: isFocused ? 6 : 0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             text,
//                             style: textStyle.copyWith(color: color),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         if (selectedItem != null)
//                           const Icon(Icons.check, color: green, size: 22),
//                       ],
//                     ),
//                   );
//                 },

//                 onChanged: (value) {
//                   profileController.selectedMarried(value)  ;
//                 },
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }






