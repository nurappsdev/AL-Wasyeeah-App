import 'package:get/get.dart';
import '../witness_controller/witness_controller.dart';

class WitnessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WitnessController>(() => WitnessController());
  }
}
