
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class NomineeDetailsScreen extends StatelessWidget {
  const NomineeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: "Nominee Profile Details".tr,fontsize: 18.sp,),),
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
                  SizedBox(height: 20.h),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 3.0,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage("https://via.placeholder.com/150"),
                              radius: 30,
                            ),
                            title: Text(
                              "Mahmudul Hasan Rabbi",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4), // Shadow color with opacity
                          blurRadius: 10.0, // Softness of the shadow
                          offset: Offset(0.5, 1), // Position of the shadow (x, y)
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, //
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          Center(
                            child: CustomText(
                              text: "Personal Details".tr,
                              fontsize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Divider(),
                          SizedBox(height: 10.h),

                          /// Relation Row
                          _buildRow("Relation:", "Cousin"),

                          /// Nominee Date Row
                          _buildRow("Nominee Date:", "30-09-2024 | 2:48 PM"),

                          /// Mobile Row
                          _buildRow("Mobile:", "+880 123456789"),

                          /// Email Row
                          _buildRow("Email:", "mahmudul1990@gmail.com"),

                          /// Marital Status Row
                          _buildRow("Marital Status:", "Married"),

                          /// Spouse's Row
                          _buildRow("Spouse’s:", "Mithila IslamJinia Chowdhury"),

                          /// Profession Row
                          _buildRow("Profession:", "Teacher"),

                          /// Mother's Name Row
                          _buildRow("Mother’s Name:", "Sultana Zaman"),

                          /// Father's Name Row
                          _buildRow("Father’s Name:", "Sultana Zaman"),

                          /// Current Address Row
                          _buildRow(
                            "Current Address:",
                            "621/A, Shajahanpur, Khilgaon,\nDhaka 1000.",
                          ),

                          /// Permanent Address Row
                          _buildRow(
                            "Permanent Address:",
                            "621/A, Shajahanpur, Khilgaon,\nDhaka 1000.",
                          ),

                          /// Buttons
                          SizedBox(height: 30.h),
                          CustomButton(
                            title: " - Remove Nominee".tr,
                            titlecolor: AppColors.redColor,
                            onpress: () {},
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
  Widget _buildRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align label and value
        children: [
          Expanded(
            flex: 1,
            child: CustomText(
              text: label.tr,
              fontsize: 16.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.start, // Align text to the start (left)
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomText(
              text: value.tr,
              fontsize: 16.sp,
              maxline: 2,
              textAlign: TextAlign.start, // Align text to the end (right)
            ),
          ),
        ],
      ),
    );
  }


}
