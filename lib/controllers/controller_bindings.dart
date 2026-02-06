import 'package:get/get.dart';
import 'profile/user_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    // Global controllers available throughout the app
    Get.put<UserController>(UserController(), permanent: true);
  }
}
