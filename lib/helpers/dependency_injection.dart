import 'package:al_wasyeah/controllers/nomineee/nominee_controller.dart';
import 'package:al_wasyeah/controllers/notification/notification_controller.dart';
import 'package:al_wasyeah/controllers/profile/home_controller.dart';
import 'package:al_wasyeah/controllers/profile/profile_controller.dart';
import 'package:al_wasyeah/controllers/property_distribution_calculation/property_distribution_calculation_controller.dart';
import 'package:al_wasyeah/controllers/splash/splash_controller.dart';
import 'package:al_wasyeah/controllers/wasyyah/wasyyah_controller.dart';
import 'package:al_wasyeah/controllers/witness_controller/witness_controller.dart';
import 'package:al_wasyeah/controllers/zakat_calculation/zakat_calculator_controller.dart';
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
