import 'package:al_wasyeah/helpers/app_routes.dart';
import 'package:al_wasyeah/helpers/prefs_helper.dart';
import 'package:al_wasyeah/utils/app_constant.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    await Future.delayed(
        const Duration(milliseconds: 500)); // smooth transition

    final token = await PrefsHelper.getString(AppConstants.bearerToken);

    if (token.isNotEmpty) {
      Get.offAllNamed(AppRoutes.homePage);
    } else {
      Get.offAllNamed(AppRoutes.onboardingPage);
    }
  }
}
