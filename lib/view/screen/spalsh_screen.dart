import 'dart:async';

import 'package:al_wasyeah/helpers/app_routes.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () async{
   //   Get.toNamed(AppRoutes.bottomBar);
    });
  }
  bool isEnglish = true;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

   body: Container(
        padding: EdgeInsets.only(right: 10.w,left: 10.w),
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white
        ),
        child: InkWell(
            onTap: (){
              Get.toNamed(AppRoutes.loginScreen,preventDuplicates: false);
            },
            child: Stack(
              children: [
                Center(child:Image.asset(AppImages.splashImg1,fit: BoxFit.fitHeight,
                  height: double.infinity,
                  width: double.infinity,)),
               Positioned(
                 top: 330.h,
                 right: 60.w,
                 left: 60,
                 child: Container(
                 height: Get.height,
                   child: CustomText(text: "ayat".tr,maxline: 20,fontsize: 16.sp,),
                 ),
               ),
                Positioned(
                  top: 30.h,
                  right: 4.w,
                  child: Row(
                    children: [
                      Text(
                        'language'.tr,
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                      ),
                      const SizedBox(width: 8),
                      // Toggle for language
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEnglish = false;
                                  Get.updateLocale(const Locale('bd', 'BD'));
                                });
                              },
                              child: Text(
                                'Eng',
                                style: TextStyle(
                                  color: isEnglish ? Colors.grey : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Switch(

                              value: isEnglish,
                              onChanged: (value) {
                                setState(() {
                                  isEnglish = value;
                                  Get.updateLocale(value ? const Locale('en', 'US') : const Locale('bd', 'BD'));
                                });
                              },
                              activeColor: AppColors.primaryColor,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: Colors.grey,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEnglish = true;
                                  Get.updateLocale(const Locale('en', 'US'));
                                });
                              },
                              child: Text(
                                'বাং',
                                style: TextStyle(
                                  color: isEnglish ? Colors.white : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
