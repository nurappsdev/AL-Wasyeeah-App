import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
   body: Container(
        padding: EdgeInsets.only(right: 10.w,left: 10.w),
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white
        ),
        child: Center(child:  Image.asset(AppImages.splashImg2)),
      ),
    );
  }
}
