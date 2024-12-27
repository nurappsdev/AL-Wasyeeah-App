import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class WasiyahEditScreen extends StatelessWidget {
  const WasiyahEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: "Wasiyah Edit".tr,fontsize: 18.sp,),),
          body: Container(
            height: Get.height,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "আমি".tr,
                        fontWeight: FontWeight.w500,
                        fontsize: 16.sp, // Unified font size
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "আমি".tr,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
                          ),
                        ),
                      ),
                      CustomText(
                        text: " বাড়ী নং ".tr,
                        fontWeight: FontWeight.w500,
                        fontsize: 16.sp, // Unified font size
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: " বাড়ী নং ".tr,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "রোড নং".tr,
                        fontWeight: FontWeight.w500,
                        fontsize: 16.sp, // Unified font size
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "রোড নং".tr,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
                          ),
                        ),
                      ),
                      CustomText(
                        text: " বাংলাদেশ- ".tr,
                        fontsize: 16.sp, // Unified font size
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: "পিতাঃ ".tr,
                        fontsize: 16.sp, // Unified font size
                        fontWeight: FontWeight.w500,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "পিতা".tr,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 300.h,
                    child: CustomText(
                      maxline: 10,
                      fontsize: 16.sp, // Unified font size
                      text: "তাঁর এই বলে স্বাক্ষ্য দিচ্ছি যে, আল্লাহ্ ছাড়া কোন ইলাহ \nনেই, তিনি একক কোন শরীক নেই। আমি আরও স্বাক্ষ্য \nদিচ্ছি যে মুহাম্মদ (সাল্লাল্লাহু আলাইহিস সালাম) তাঁর \nবান্দা ও রাসুল। আমি সম্পূর্ণ শারীরিক ও মানসিকভাবে \nসূস্থ অবস্থায়, কোন প্রকার বাহ্যিক চাপ বা প্রভাব ব্যতীত \nস্বপ্রনোদিত হয়ে এই ওয়াসিয়াহ (ইচ্ছা নাম ) প্রকাশ \nকরছি। এই ওয়াসিয়াহ (ইচ্ছানামা) আমার মা, স্ত্রী, \nসন্তান, আত্মীয় স্বজন এবং প্রিয় মুসলিমদের উদেশ্যে লিখছি",
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: 60.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(title: "Cancel".tr, onpress: (){},width: 100.w,height: 40.h,color: Colors.red,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(title: "Save".tr, onpress: (){},width: 100.w,height: 40.h,color: AppColors.primaryColor,),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),

    );
  }
}
