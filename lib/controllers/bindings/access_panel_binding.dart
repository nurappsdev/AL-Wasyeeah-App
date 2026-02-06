import 'package:get/get.dart';
import '../access_phanel/access_phanel_controller.dart';

class AccessPanelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccessPhanelController>(() => AccessPhanelController());
  }
}
