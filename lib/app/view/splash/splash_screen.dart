import 'package:al_wasyeah/app/controllers/splash/splash_controller.dart';
import 'package:al_wasyeah/core/utils/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 600),
          opacity: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.app_logo,
                height: 120,
              ),
              const SizedBox(height: 16),
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            ],
          ),
        ),
      ),
    );
  }
}
