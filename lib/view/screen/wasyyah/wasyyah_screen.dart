
import 'package:al_wasyeah/helpers/app_routes.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/view/widgets/custom_button.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'add_new_washyia_screen.dart';
import 'wasiyah_preview_screen.dart';

class WasyyahScreen extends StatelessWidget {
  const WasyyahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(
        text: "Wasyyah",
        fontsize: 18.sp,
        fontWeight: FontWeight.w600,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(title: "Preview".tr, onpress: (){
            Get.off(()=>WasyyahPreviewScreen(),preventDuplicates: false);
          },width: 100.w,height: 40.h,color: AppColors.primaryColor,),
        )
      ],
      ),
      body: Container(
        height: Get.height,
        width: double.infinity,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                CustomText(text: "Bismillahir Rahmanir Raheem".tr,fontsize: 14,),
                SizedBox(height: 10.h,),
                Divider(color: AppColors.primaryColor,height: 14,),
                SizedBox(height: 10.h,),
                CustomText(text: "ওয়াসিয়াহ (ইচ্ছানামা)".tr,fontsize: 20.sp,fontWeight: FontWeight.w700,),
                SizedBox(height: 10.h,),
                Divider(color: AppColors.primaryColor,height: 14,),
                SizedBox(height: 10.h,),
                CustomText(text: "আসসালামু আলাইকুম ওয়া রাহমাতুল্লা ইন্নালহামদালিল্লাহি রাব্বিল আ'লামীন \n ওয়াসসালাতু ওয়াসসালামু আলা রাসুলিল্লাহ \n (সাল্লাল্লাহু আলাইহিসসালাম)।",maxline: 4),
                SizedBox(height: 20.h,),
            
                ///====================================নিজের পরিচিতি================================
                SizedBox(
                  height: 340.h,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                        color: Colors.white, // Background color
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
                            spreadRadius: 2, // How much the shadow spreads
                            blurRadius: 5, // Softness of the shadow
                            offset: Offset(0, 3), // Offset in x and y (horizontal, vertical)
                          ),
                        ],
                      ),
                       child: Column(
                         children: [
                           SizedBox(height: 5.h,),
                           CustomText(text: "নিজের পরিচিতি",fontsize: 16.sp,),
                           Padding(
                             padding:  EdgeInsets.only(left: 80,right: 80),
                             child: Divider(color: AppColors.primaryColor,endIndent: 2.2,thickness: 1.2,),
                           ),
                           SizedBox(height: 6.h,),
                           CustomText(fontWeight:FontWeight.w500,text: "আমি বাড়ী নং রোড নং বাংলাদেশ- পিতাঃ তাঁর এই বলে \nস্বাক্ষ্য দিচ্ছি যে, আল্লাহ্ ছাড়া কোন ইলাহ নেই, তিনি একক \nকোন শরীক নেই। আমি আরও স্বাক্ষ্য দিচ্ছি যে মুহাম্মদ \n(সাল্লাল্লাহু আলাইহিসসালাম) তাঁর বান্দা ও রাসুল।\n আমি সম্পূর্ণ শারীরিক ও মানসিকভাবে সূস্থ অবস্থায়, \nকোন প্রকার বাহ্যিক চাপ বা প্রভাব ব্যতীত স্বপ্রনোদিত \nহয়ে এই ওয়াসিয়াহ (ইচ্ছা নাম ) প্রকাশ করছি। \nএই ওয়াসিয়াহ (ইচ্ছানামা) আমার মা, স্ত্রী, সন্তান, \nআত্মীয় স্বজন এবং প্রিয় মুসলিমদের উদেশ্যে লিখছি",textAlign: TextAlign.start,),
                           SizedBox(height: 10.h,),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               GestureDetector(
                                   onTap: (){
                                     Get.toNamed(AppRoutes.wasyyahEditScreen,preventDuplicates: false);
                                   },
                                   child: _iconTextCon(Icons.edit_calendar_outlined,"Edit")),
            
                               _iconTextCon(Icons.remove_red_eye_outlined,"View"),
                             ],
                           )
                         ],
                       ),
                    ),
                  ),
                ),
                ///====================================নিজের পরিচিতি================================
                SizedBox(height: 20.h,),
                SizedBox(
                  height: 440.h,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                        color: Colors.white, // Background color
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
                            spreadRadius: 2, // How much the shadow spreads
                            blurRadius: 5, // Softness of the shadow
                            offset: Offset(0, 3), // Offset in x and y (horizontal, vertical)
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(height: 5.h,),
                            CustomText(text: "পরিবারের প্রতি দ্বীন বিষয়ক ওয়াসিয়াহ".tr,fontsize: 16.sp,),
                            Padding(
                              padding:  EdgeInsets.only(left: 20,right: 20),
                              child: Divider(color: AppColors.primaryColor,endIndent: 2.2,thickness: 1.2,),
                            ),
                            SizedBox(height: 6.h,),
                            CustomText(textAlign: TextAlign.start,fontWeight:FontWeight.w500,text: "আমার মৃত্যুর সংবাদ শোনামাত্র সকলেই আমার জন্য \nআল্লাহর কাছে ক্ষমা ও রহমত কামনা করে দোয়া করবেন। \nআমার মৃত্যুর পর মরদেহ যেন কোন প্রকার কাটাছেড়া \nবা Post mortem না করা হয়। আমি আমার পরিবারের \nসকল সদস্য, আত্মীয়স্বজন ও শুভাকাঙ্ক্ষীদের বলছি, \nআমার মৃত্যুর পর যেন অতি শোকে wail বা উচ্চস্বরে \nকান্নাকাটি না করা হয়। \nকেননা মৃত্যু একটি স্বাভাবিক ব্যপার। আল্লাহ্ বলেন : \n“প্রত্যেককে মৃত্যুর স্বাদ আস্বাদন করতে হবে। \nআমি তোমাদেরকে মন্দ ও ভাল  দ্বারা পরীক্ষা করে থাকি \nএবং আমারই কাছে তোমরা প্রত্যাবর্তিত হবে”। \n(সুরা  আনবিয়া:৩৫)।",),
                            SizedBox(height: 10.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: (){

                                    },
                                    child: _iconTextCon(Icons.edit_calendar_outlined,"Edit")),

                                _iconTextCon(Icons.remove_red_eye_outlined,"View"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                CustomButton(
                  title: "Add more content".tr,
                  titlecolor: AppColors.primaryColor,
                  onpress: () {
                    Get.to(()=>AddNewWashyiaScreen(),preventDuplicates: false);
                  },
                ),
                SizedBox(height: 20.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
Widget _iconTextCon(IconData icon, String text){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 35.h,
        width: 80.w,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),color: Color(0xff757575)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon,color: Colors.white,),
            CustomText(text: text,color: Colors.white,fontsize: 16.sp,)
          ],
        ),
      ),
    );
}
}
