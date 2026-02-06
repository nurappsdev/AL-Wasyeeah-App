import 'package:get/get.dart';
import '../wasyyah/wasyyah_controller.dart';

class WasyyahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WasyyahController>(() => WasyyahController());
  }
}
