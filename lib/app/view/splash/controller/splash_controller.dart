import 'package:al_wasyeah/app/core/route/route_names.dart';
import 'package:al_wasyeah/app/core/services/shared_pref/prefs_service.dart';
import 'package:al_wasyeah/app/core/utils/app_constant.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    await Future.delayed(const Duration(milliseconds: 500)); // smooth transition

    final token = await PrefsHelper.getString(AppConstants.bearerToken);

    if (token.isNotEmpty) {
      Get.offAllNamed(RouteName.homePage);
    } else {
      Get.offAllNamed(RouteName.onboardingPage);
    }
  }
}
