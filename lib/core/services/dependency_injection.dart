import 'package:al_wasyeah/app/controllers/access_control/access_control_controller.dart';
import 'package:al_wasyeah/app/controllers/contact_us/contact_us_controller.dart';
import 'package:al_wasyeah/app/controllers/nomineee/nominee_controller.dart';
import 'package:al_wasyeah/app/controllers/notification/notification_controller.dart';
import 'package:al_wasyeah/app/controllers/home/home_controller.dart';
import 'package:al_wasyeah/app/controllers/profile/profile_controller.dart';
import 'package:al_wasyeah/app/controllers/property_distribution_calculation/property_distribution_calculation_controller.dart';
import 'package:al_wasyeah/app/controllers/splash/splash_controller.dart';
import 'package:al_wasyeah/app/controllers/wasyyah/wasyyah_controller.dart';
import 'package:al_wasyeah/app/controllers/witness_controller/witness_controller.dart';
import 'package:al_wasyeah/app/controllers/zakat_calculation/zakat_calculator_controller.dart';
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
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<NotificationController>(() => NotificationController());
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
    Get.lazyPut<PropertyDistributionCalculationController>(() => PropertyDistributionCalculationController());
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
