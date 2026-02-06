import 'package:get/get.dart';
import '../property_distribution_calculation/property_distribution_calculation_controller.dart';

class PropertyDistributionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropertyDistributionCalculationController>(
      () => PropertyDistributionCalculationController(),
    );
  }
}
