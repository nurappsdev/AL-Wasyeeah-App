
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../helpers/app_routes.dart';
import '../../helpers/prefs_helper.dart';
import '../../utils/app_constant.dart';
import '../../utils/app_image.dart';
import '../widgets/widgets.dart';
import 'package:http/http.dart' as http;

class FirstSplashScreen extends StatefulWidget {
  const FirstSplashScreen({super.key});

  @override
  State<FirstSplashScreen> createState() => _FirstSplashScreenState();
}

class _FirstSplashScreenState extends State<FirstSplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () async {
      try {
        fetchAndSetLocation();
        String token = await PrefsHelper.getString(AppConstants.bearerToken);
        if (token.isNotEmpty) {
          Get.offAllNamed(AppRoutes.homeScreen);
        } else {
          Get.toNamed(AppRoutes.splashScreen, preventDuplicates: false);
        }
      } catch (e) {
        // Optional: Handle error
        Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
      }
    });
  }

  Future<void> fetchAndSetLocation() async {
    try {
      final response = await http.get(Uri.parse('https://ipwho.is/'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final double latitude = data['latitude'];
        final double longitude = data['longitude'];

        // Save to SharedPreferences using PrefsHelper
        await PrefsHelper.setString(AppConstants.latitude, latitude.toString());
        await PrefsHelper.setString(AppConstants.longitude, longitude.toString());

        print('Location saved: lat=$latitude, long=$longitude');
      } else {
        print('Failed to fetch location. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching location: $e');
    }
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

