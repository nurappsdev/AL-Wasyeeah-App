
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../helpers/app_routes.dart';
import '../../helpers/prefs_helper.dart';
import '../../utils/app_constant.dart';
import '../../utils/app_image.dart';
import '../widgets/widgets.dart';

class FirstSplashScreen extends StatefulWidget {
  const FirstSplashScreen({super.key});

  @override
  State<FirstSplashScreen> createState() => _FirstSplashScreenState();
}

class _FirstSplashScreenState extends State<FirstSplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () async{
      String token = await PrefsHelper.getString(AppConstants.bearerToken);
      if(token.isNotEmpty){
        Get.offAllNamed(AppRoutes.homeScreen);
      }else{
        Get.toNamed(AppRoutes.splashScreen,preventDuplicates: false);
      }
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

          ],
        ),
      ),
    );
  }
}

