import 'package:al_wasiyyath/app/view/access_control/controller/access_control_controller.dart';
import 'package:al_wasiyyath/app/view/auth/controller/auth_controller.dart';
import 'package:al_wasiyyath/app/view/contact_us/controller/contact_us_controller.dart';
import 'package:al_wasiyyath/app/view/nominee/controller/nominee_controller.dart';
import 'package:al_wasiyyath/app/view/notification/controller/notification_controller.dart';
import 'package:al_wasiyyath/app/view/home/controller/home_controller.dart';
import 'package:al_wasiyyath/app/view/profile/controller/profile_controller.dart';
import 'package:al_wasiyyath/app/view/property_distribution_calculation/controller/property_distribution_calculation_controller.dart';
import 'package:al_wasiyyath/app/view/splash/controller/splash_controller.dart';
import 'package:al_wasiyyath/app/view/wasiyyah/controller/wasyyah_controller.dart';
import 'package:al_wasiyyath/app/view/witnessess/controller/witness_controller.dart';
import 'package:al_wasiyyath/app/view/zakat_calculator/controller/zakat_calculator_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<NotificationController>(() => NotificationController(),
        fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  }
}

class WasyyahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WasyyahController>(() => WasyyahController());
  }
}

class WitnessesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WitnessController>(() => WitnessController());
  }
}

class NomineesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NomineeController>(() => NomineeController());
  }
}

class AccessControlBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccessControlController>(() => AccessControlController());
  }
}

class PropertyDistributionCalculationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropertyDistributionCalculationController>(
        () => PropertyDistributionCalculationController());
  }
}

class ZakatCalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZakatCalculatorController>(() => ZakatCalculatorController());
  }
}

class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactUsController>(() => ContactUsController());
  }
}
